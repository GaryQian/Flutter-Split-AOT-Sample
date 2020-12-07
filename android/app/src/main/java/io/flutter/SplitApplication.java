// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter;

import com.google.android.play.core.splitcompat.SplitCompatApplication;
import androidx.annotation.CallSuper;
import io.flutter.embedding.engine.dynamicfeatures.PlayStoreDynamicFeatureManager;
import io.flutter.FlutterInjector;

/**
 * Flutter implementation of {@link android.app.Application}, managing application-level global
 * initializations.
 *
 * <p>Using this {@link android.app.Application} is not required when using APIs in the package
 * {@code io.flutter.embedding.android} since they self-initialize on first use.
 */
public class SplitApplication extends SplitCompatApplication {
// public class SplitApplication extends Application {
  @Override
  @CallSuper
  public void onCreate() {
    super.onCreate();
    PlayStoreDynamicFeatureManager dynamicFeatureManager = new PlayStoreDynamicFeatureManager(this, null);
    FlutterInjector.setInstance(new FlutterInjector.Builder().setDynamicFeatureManager(dynamicFeatureManager).build());
  }
}
