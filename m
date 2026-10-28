Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28582606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=s1G4iNj7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR92Lxfz2ygd;
	Thu, 29 Oct 2026 10:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176210;
	cv=none; b=je/zcepcUq8QbNa7RR69O/mEluBvg2/4ahvtXo3nMd59+VkQvUbcL1pxwgZMEMS16/C3yS9Nxc1pmdUpa/BrOm34p0NkBi5yaY03JzR1n1kZ5eimmhyVEV2iQf5nfjd+HVxcHR5bwtZTFmC0xrdrGq6QiDL2/Uef6DgwxLyjCuf5rUT8BSUjD9JgTasCies4iHUJA0/NxtN/MsPwWYHOzyRYL6O+Rz/Y3RfQzVRtl/MfQk7zt3RiQAHAr3/W7WF4c5sNqe9qEid8QWGhnTGISI1hnrzir/KW5JO2fn/bGcfAWFtUIkhcVYOiWTrHY8YplXAjV/v6rEp04Acvk0yS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176210; c=relaxed/relaxed;
	bh=DLae2gx4aGYIpiU/bvQJfKJhKs4nNCXiSW/qMDyeW24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPM8zE78sTsoNoVmP1fOkSp8rpMWSw9P1m8fcWXRZ3kGDUFk79bVmHWAlRBQOa841TKWB/CFvgShQpKg6KtIc4LzNwBVXRucJoi9aTf/QnHlv+dioKI0AAFTiPtwy3VKbUQ/eeDeFIPVnFgpHdcQD8zuh4QeNLhwIfkOeUYrIeUCaaT4AWyKe+CwkkSgntnplnWX6Kakq1Nr60IeBhxliyTIg34acXMW++C7rYxTBuJmk5dH+q/PplybFr2cTra4FgPJPzdE0PElLD924UB0s9hepi2ZrUiMzhDiCLDEeGzL9gRzd4JDzW7UrsJ7Uob/4KMbpWuQzyBuuq9x21RUag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=s1G4iNj7; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=s1G4iNj7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0ss3dwZz2xwL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175635;
	bh=DLae2gx4aGYIpiU/bvQJfKJhKs4nNCXiSW/qMDyeW24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s1G4iNj7/OxMe3QEsIAEnZ0bhFm524AJi+UtsiJDNZZkymmDz57s/cSBMC+SkARw3
	 i3VKwlDdDVQAtn3D0ok4bdXGCRiRr75QTXzaZRCjPUoxQd2Dwf/537SkAttNRm5m+i
	 dIZin/56CDIf1Rz1jHjqkNsZ3h7kYtj+ZQxQXxGI=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 67144FBCF7;
	Wed, 28 Oct 2026 08:20:35 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:44 +0000
Message-ID: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the macro __nonnull_args() to wrap raw compiler
attribute.

Replace __attribute__((nonnull)) with __nonnull_args() to standardize
nonnull attribute usage across the tree and keep the attribute's quirks
in one place rather than open-coded at every call site.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
 drivers/gpu/drm/i915/i915_request.h        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index a2f4b6758a65..648d0b4139cf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -127,7 +127,7 @@ __deprecated
 struct drm_gem_object *
 drm_gem_object_lookup(struct drm_file *file, u32 handle);
 
-__attribute__((nonnull))
+__nonnull_args()
 static inline struct drm_i915_gem_object *
 i915_gem_object_get(struct drm_i915_gem_object *obj)
 {
@@ -135,7 +135,7 @@ i915_gem_object_get(struct drm_i915_gem_object *obj)
 	return obj;
 }
 
-__attribute__((nonnull))
+__nonnull_args()
 static inline void
 i915_gem_object_put(struct drm_i915_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index b09135301f39..f559203c332d 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -437,12 +437,12 @@ void i915_request_cancel(struct i915_request *rq, int error);
 long i915_request_wait_timeout(struct i915_request *rq,
 			       unsigned int flags,
 			       long timeout)
-	__attribute__((nonnull(1)));
+	__nonnull_args(1);
 
 long i915_request_wait(struct i915_request *rq,
 		       unsigned int flags,
 		       long timeout)
-	__attribute__((nonnull(1)));
+	__nonnull_args(1);
 #define I915_WAIT_INTERRUPTIBLE	BIT(0)
 #define I915_WAIT_PRIORITY	BIT(1) /* small priority bump for the request */
 #define I915_WAIT_ALL		BIT(2) /* used by i915_gem_object_wait() */
-- 
2.53.0-Meta


