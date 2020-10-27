//
//  ChartView.swift
//  Trashure
//
//  Created by Gus Adi on 27/10/20.
//

import Macaw

open class ChartViewTahun: MacawView {
    
    open var completionCallback: (() -> ()) = { }
    
    private var backgroundGroup = Group()
    private var mainGroup = Group()
    private var captionsGroup = Group()
    
    private var barAnimations = [Animation]()
    private let barsValues = [125, 0, 0, 0]
    private let barsCaptions = ["2019", "2020", "2021", "2022"]
    private let barsCount = 4
    private let barsSpacing = 60
    private let barWidth = 8
    private let barHeight = 120
    
    private let maxValue = 2000
    
    private let backgroundLineSpacing = 18
    
    private let captionsY = ["100Kg", "70Kg", "50Kg", "35Kg", "25Kg", "10Kg"]
    
    private let gradientColor = Color.rgba(r: 255, g: 87, b: 34, a: 1.0)
    
    private func createScene() {
        let viewCenterX = Double((self.frame.width + 30) / 2)
        
        let barsWidth = Double((barWidth * barsCount) + (barsSpacing * (barsCount - 1)))
        let barsCenterX = viewCenterX - barsWidth / 2
        
        mainGroup = Group()
        for barIndex in 0...barsCount - 1 {
            let barShape = Shape(
                form: RoundRect(
                    rect: Rect(
                        x: Double(barIndex * (barWidth + barsSpacing)),
                        y: Double(barHeight),
                        w: Double(barWidth),
                        h: Double(0)
                    ),
                    rx: 5,
                    ry: 5
                ),
                fill: gradientColor
            )
            mainGroup.contents.append([barShape].group())
        }
        
        backgroundGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        mainGroup.place = Transform.move(dx: barsCenterX, dy: 90)
        
        captionsGroup = Group()
        captionsGroup.place = Transform.move(
            dx: barsCenterX,
            dy: 100 + Double(barHeight)
        )
        for barIndex in 0...barsCount - 1 {
            let text = Text(
                text: barsCaptions[barIndex],
                font: Font(name: "SF UI Display", size: 12),
                fill: Color.rgba(r: 113, g: 128, b: 147, a: 1.0)
            )
            text.align = .mid
            text.place = .move(
                dx: Double((barIndex * (barWidth + barsSpacing)) + barWidth / 2),
                dy: 0
            )
            captionsGroup.contents.append(text)
        }
        
        let milesCaptionGroup = Group()
        for index in 0...captionsY.count - 1 {
            let text = Text(
                text: captionsY[index],
                font: Font(name: "SF UI Display", size: 12),
                fill: Color.rgba(r: 113, g: 128, b: 147, a: 1.0)
            )
            text.place = .move(
                dx: 0,
                dy: Double((backgroundLineSpacing * 2) * index)
            )
            text.opacity = 1
            milesCaptionGroup.contents.append(text)
        }
        
        let chartGroup = [milesCaptionGroup].group(place: Transform.move(dx: barsCenterX - 60, dy: 20))
        self.node = [mainGroup, captionsGroup, chartGroup].group()
    }
    
    private func createAnimations() {
        barAnimations.removeAll()
        for (index, node) in mainGroup.contents.enumerated() {
            if let group = node as? Group {
                var heightValue = 0
                
                if barsValues[index] < maxValue {
                    heightValue = barsValues[index]
                    print("height value \(index): \(heightValue)")
                } else {
                    heightValue = 200
                    print("height value \(index): \(heightValue)")
                }
                
                let animation = group.contentsVar.animation({ t in
                    let value = Double(heightValue) / 100 * (t * 100)
                    print("t: \(t)")
                    print("value \(index): \(value)")
                    let barShape = Shape(
                        form: RoundRect(
                            rect: Rect(
                                x: Double(index * (self.barWidth + self.barsSpacing)),
                                y: Double(self.barHeight) - Double(value),
                                w: Double(self.barWidth),
                                h: Double(value)
                            ),
                            rx: 5,
                            ry: 5
                        ),
                        fill: self.gradientColor
                    )
                    return [barShape]
                }, during: 0.2, delay: 0).easing(Easing.easeInOut)
                barAnimations.append(animation)
            }
        }
    }
    
    open func play() {
        createScene()
        createAnimations()
        barAnimations.sequence().play()
    }
}
