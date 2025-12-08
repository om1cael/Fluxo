# Fluxo
**Fluxo** is a mobile news application developed in **Flutter**. This project serves as a focused learning exercise to implement and validate the principles of the **Model-View-ViewModel (MVVM)** architectural pattern, **Clean Architecture**, **Riverpod** and **testing**.

The application fetches real-time articles from the [**NewsAPI**](https://newsapi.org/) and allows users to filter content by category.

## Screenshots
<img src="https://github.com/user-attachments/assets/a7d09485-e914-4720-ad84-ac2ca7fcc6e7" width=200>
<img src="https://github.com/user-attachments/assets/7dba5b0f-cfc0-4e31-aa66-9d8c16038945" width=200>
<img src="https://github.com/user-attachments/assets/209d5ea0-9ed6-458f-837f-2f6ec779d9aa" width=200>


## 🔑 Key Features

  * **Article Filtering:** Ability to switch between fetching general news and news filtered by specific categories.
  * **External API:** Integration with the **NewsAPI** for data source.

## 🚀 Getting Started

1.  **Clone the repository.**
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Setup Environment Variables:**
    Create a **`.env`** file in the project root and add your NewsAPI key:
    ```
    API_KEY=YOUR_API_KEY_HERE
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```
## 📜 License
This project is licensed under [GPL-3.0](https://github.com/om1cael/Fluxo/blob/main/LICENSE).
