import SwiftUI

struct CardView: View {
  var title: String
  var subtitle: String
  var trailingText: String
  var imageName: String

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color(red: 239/255, green: 239/255, blue: 239/255))
        .shadow(color: .gray.opacity(0.4), radius: 1, x: 1, y: 1)

      HStack {
        VStack(alignment: .leading, spacing: 30) {
          Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.secondary)

          Text(subtitle)
            .font(.title3)
            .fontWeight(.medium)
            .foregroundColor(.gray)
        }
        .padding()

        Spacer()

        GeometryReader { geometry in
          ZStack {
            Image(imageName)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .padding([.trailing], -100)
              .frame(width: geometry.size.width, height: geometry.size.height)
              .clipped()
              .cornerRadius(16)

            Text(trailingText)
              .font(.headline)
              .foregroundColor(.gray)
              .padding([.bottom], geometry.size.width / 3)
              .padding([.trailing], 25)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
          }
        }
      }
    }
    .frame(width: 350, height: 150)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(title: "Mellow Out", subtitle: "Emotion", trailingText: "5 mins", imageName: "ring-circle")
  }
}
