import SwiftUI
import UIKit

// Renamed ConfettiView to GameConfettiView to avoid conflicts
struct GameConfettiView: UIViewControllerRepresentable {
    class ConfettiViewController: UIViewController {
        private var emitterLayer: CAEmitterLayer!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
            setupEmitterLayer()
        }

        private func setupEmitterLayer() {
            emitterLayer = CAEmitterLayer()
            emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)
            emitterLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
            emitterLayer.emitterShape = .line
            emitterLayer.renderMode = .additive

            let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple]
            var cells: [CAEmitterCell] = []

            for color in colors {
                let cell = createConfettiCell(color: color)
                cells.append(cell)
            }

            emitterLayer.emitterCells = cells
            view.layer.addSublayer(emitterLayer)
        }

        private func createConfettiCell(color: UIColor) -> CAEmitterCell {
            let cell = CAEmitterCell()
            cell.birthRate = 250
            cell.lifetime = 10.0
            cell.velocity = 300
            cell.velocityRange = 100
            cell.emissionRange = .pi
            cell.contents = createConfettiLayer(color: color)
            cell.scale = 0.2
            cell.scaleRange = 0.1
            cell.yAcceleration = 250
            cell.alphaSpeed = -0.3
            return cell
        }

        private func createConfettiLayer(color: UIColor) -> CGImage? {
            let size = CGSize(width: 25, height: 25)
            UIGraphicsBeginImageContext(size)
            color.setFill()
            let rect = CGRect(origin: .zero, size: size)
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image?.cgImage
        }

        func startConfetti() {
            emitterLayer.birthRate = 1
        }

        func stopConfetti() {
            emitterLayer.birthRate = 0
        }
    }

    func makeUIViewController(context: Context) -> ConfettiViewController {
        return ConfettiViewController()
    }

    func updateUIViewController(_ uiViewController: ConfettiViewController, context: Context) {
        // Update the view controller if needed
    }
}

