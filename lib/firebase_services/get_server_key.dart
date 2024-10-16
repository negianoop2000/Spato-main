import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "notification-for-android-485",
            "private_key_id": "fd65e99fdf8798d9a20d85ea0bcbcea72c1967bd",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDWiG2JknCFjSK4\nhKk1k+2j5VD76ZWystmW0jyPMsBgtZ9UyJq1fCIg72S0StGAxg11/dE3+GT74YRC\nRvX4x5TkSgACQK6w9b0KAyUjEGOtXJM3CnHFBZGQltY+abObQEwQwG0vXRs+W3tI\nSjd+aHAtrfNq4OQjRBqGXFRKg014dD2TyQ4mdfdUL0eUQw1rlNqdBdFYyLbVbaaF\ndLchewvELOFvaSkpCM/fP7/iH9pnhIdJaIVSceYTKIC/W6xTtkRja7q7Jxcsj5Of\nYhDa7biXZdaeQCiXPWYWnNZpWclRVciWF9ecbElzSGjT6pVEKwXurxsS1pBed00l\nE8fZsSS1AgMBAAECggEAE1WvXZc7meW669tU7rW61Ksdrd6C9dyFnMCs4ZEG4pBr\n4DXGL7YU01gQAOm/UPZIj0pFWWCDJWpRQ7HmiDngkuSSdKGEvQEgvO7EoZDgEudF\ng0/nKgUS9e+KNozLOaJFWLsm+/5NrsSK61x4/OUHuy4ywn6rQPxp0ZMvq5mC2Wii\nO2MCaBPazHjdbDKuEBwu4Nz1zIlgelvCwiQMyrtfQCpGKzfnA8Q4HVcZm5R/HYWU\nt1hI4QengCglQKnJdmCgR3sBKIu2Zcuk9BMBqOjKJXU6z4bCvUWkA5Ku8apyvsMf\nezYUG3jrPHNpjHtvD7mvMEAbbVpvQoG1IWPaYEWArwKBgQD1+x7gmNVEYJsP5+O2\ncaPuYGqZqkeiL5bns5sxN901Ylh1E/rslxKqOk9taI0D63GAAXqlyhmGf6uryoL+\nBY2hoNb0JEUWI1rVUtYFrBnkxG4TRFMwIkn5JOGZsSg2jm5MiraPruPF2wARzqh1\nInsYg+kMsfAJI1OUfrC8hW8UmwKBgQDfRWTnktxdYUrYCUsb/zJOCUDBbEUYNpzb\nYuyIEUR3gTVX5mdmbmkunRAYG2MAWjGpNc/qAfu6c3OVDovqputi+kNwNNlAW7/L\nrqdRP8E1qHnt7HvbnHvrRvR9yFJSdEmUK+fYJXybjAgxk9rAtQSZkxzBGe8PzfDJ\n1LLY36E47wKBgQCEyOToNVibKtNKCNICAOKPofipryQwRyRdO7WBIjkFwmsh+IEy\nCnOG9Sc/VnsZLJX+lc3RhYG1+2F+wTlpSzIjmCGxdYrd4oP8OFVUho0L04XgXLfT\neg8YsXIfd2TP3p9oLlFSywQmIIyvEDIb2Vs95qd9tOhw5mMN/D4H5rgKFQKBgQCa\nIVOpMY8Cv7llLfU13JQjnuufG1kPgBQEt2PGAvWa8g2bIqla4vmlfjOwEKflhF4o\nC8f+KWRXsH+n9KTOVnDEoTOQ8ErRzQS4XVeQFU0R975Eay6NypcZMqBxfKqn1TM+\nIJkqc6Zz0tWNNB6dTdlhE1eUTozkAi0ph7X3VVn87QKBgQDnJvwMgGAZdUX2r7i8\nP1vPLkqsLrIPqCNVSK7I4ZtBuAPVj/n2MRa19ScJ6DKsocw8wXYFis0WJDcEz0kP\nxdYoQe4ts6dt2upqkbu54nDHxVjMC4Pji6Whzl2LgLeJR/6oWaf6iq7JGQTUNmRS\n+yoW2L72Cv61w0ra9gqXwiMGsg==\n-----END PRIVATE KEY-----\n",
            "client_email": "firebase-adminsdk-1hby0@notification-for-android-485.iam.gserviceaccount.com",
            "client_id": "112388391122311033991",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-1hby0%40notification-for-android-485.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
      ),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}