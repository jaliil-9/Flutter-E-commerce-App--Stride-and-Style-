# Stripe ProGuard rules
-keep class com.stripe.android.** { *; }
-dontwarn com.stripe.android.**
-keep class com.stripe.android.pushProvisioning.** { *; }
-keep class com.stripe.android.view.** { *; }

# Keep push provisioning related classes
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivity { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivity$* { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$* { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider { *; }

# Keep React Native Stripe SDK classes
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**