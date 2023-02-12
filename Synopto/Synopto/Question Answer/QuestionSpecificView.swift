
import SwiftUI

struct QuestionSpecificView: View {
    
    class CounterData: ObservableObject {
        var counter: Int = 5
    }
    
    @Binding var suburl: String
    @StateObject var qData = QuestionModel()
    @StateObject var qsData = QuestionSpecificModel()
    @State var qtext = "Loading..."
    @State var answer = "          "
    @State var userA: String = ""
    //@State var torf = ""
    @State var checker = false
    @State var clicked = false
    @StateObject var counterData = CounterData()
    
    @State private var torf: String = ""
    @State private var isLoading = true
    

    var body: some View {
        ZStack {
            Image("Background2 4")
                .resizable()
                .frame(minWidth: 400, minHeight: 900)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Text("\(qtext)")
                        .font(Font.custom("Rajdhani-Regular", size: 24))
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                
                .task {
                    await qData.getData(suburl: suburl)
                    qtext = qData.question
                    
                }
                
                
                HStack {
                    TextField("Answer: ", text: $userA)
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .foregroundColor(.black)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                Button(action: {
                    self.qsData.postData(session_name: self.suburl, question: self.qtext, user_answer: self.userA)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        // Perform some action after 5 seconds
                        self.isLoading = false
                        if qsData.is_correct{
                            self.torf = "Correct!"
                            counterData.counter += 1
                        }
                        else {
                            self.torf = "Incorrect."
                            counterData.counter -= 1
                        }
                    }
                    //clicked = true
                        //await qsData.postData(session_name: self.suburl, question: self.qtext, user_answer: self.userA)
                    
                    
                   /* if qsData.is_correct {
                        torf = "Correct!"
                    }
                    else if !qsData.is_correct{
                        torf = "Incorrect :/"
                    }*/
                })
                {
                    HStack {
                        Text("Submit")
                            .font(Font.custom("Rajdhani-Regular", size: 34))
                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                }
                
                HStack {
                    Text("\(qsData.true_answer)")
                        .font(Font.custom("Rajdhani-Regular", size: 17))
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 350)
                .padding()
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                
                    HStack {
                        if isLoading {
                            Text("Loading...")
                        } else {
                            Text("\(String(torf))")
                                .font(Font.custom("Rajdhani-Regular", size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(width: 350)
                    .padding()
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    /*.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.isLoading = false
                            self.torf = qsData.is_correct
                        }
                    }*/
            }
        }
    }
}

struct QuestionSpecificView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionSpecificView(suburl: .constant("some-value"))
    }
}

