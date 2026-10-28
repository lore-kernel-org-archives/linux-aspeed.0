Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625E606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=iyuSnZld
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNfW1FYLz2yWy;
	Thu, 29 Oct 2026 10:21:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176207;
	cv=none; b=NLKKymVnwzyvzsWh7EUveK8hVaH9IlPTail7JKZEk/vuOj6omN4a/lP5yZ4sGRvQbhnGogEbRCSGzYf2UPKLmleZUcILQFGP8OE6xEDh36Bltn6fwcV8AjW1Uni35W0ArI9OBli0SaDc/V1um6z+51Dti2l8gLabdUiaIPeKjWwjBIs+AQXN/B4hDhmkEsOImQl2kBaP+MKMKt106PjoECxLo1BD4bJSwYiFLYR0jheBGkhyJoUsnzpMxpPiv1Wezd8u+WWehIMBIKrnpD7f9pMVHZ13pSX/5+adztzCgIWH/d2aB/8i3RJuHCM4Fe0CG/kXDiKGQP9U5Tw7LwfCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176207; c=relaxed/relaxed;
	bh=SMf0dV4x3xb+DslLmuw7FBFheVT29/cwuNdKSpo2QkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHbxWrvMlvyXINFDt+5V+oyIt+ujheZmjO8EgPkCL78+noBnTmVt8e7fiDmrtd3jc7A7GIvXKjbfkmkUSDxW41I3rmglUJjksT6ywBg6fO/aVSq7OHzP5CmV3702hlri0mvKpXKwun7tymdrG6OA7da7oDqh7Y8uaCt9VD8q8Y+bh19srpBpu1Unk/5W2Q2UZ9x2QG4Xo17qMMytL53nnHMu87kL5NOUEkbiqoMBq3lk5klnDX+esHC+b/+KrHqXw/jil9k/g/SvYJWMM05mNXOQlD2rFS8ktEjSgJp4VqUAtGPXZ4kfBddXUxJnPvPZi1ypxu/ORJBRilxUnU1zZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=iyuSnZld; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=iyuSnZld;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0sm6WG9z2yPG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175633;
	bh=SMf0dV4x3xb+DslLmuw7FBFheVT29/cwuNdKSpo2QkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyuSnZldpZjUpO/QwNk+P5YouZek0N2mycnUxbkQccvDC4YJ19S4/mULi0aeehza5
	 68UlH00B7Uiw50tvUL0mmPirCWsysK2dNqpdy84iHfp+1EmJSSkCPH4nrPYKSc8ftb
	 VX/gnIntc+RIw7VOplejxDi+mip28Hr6aXN6ETg8=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 65638FBCE4;
	Wed, 28 Oct 2026 08:20:33 +0000 (UTC)
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
Subject: [PATCH 01/10] docs: xforms_lists: support __nonnull_args()
Date: Wed, 28 Oct 2026 08:19:40 +0000
Message-ID: <fd33c32bb1f1cf80721887b6e9bfa49749e03d20.1793027261.git.d@ilvokhin.com>
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

Avoid kernel-doc warnings by supporting __nonnull_args()
as a function transform.

This is a preparatory change for the treewide migration from
__attribute__((nonnull)) to __nonnull_args() macro.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/lib/python/kdoc/xforms_lists.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 320f977c5bac..a8c47ede8637 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -108,6 +108,7 @@ class CTransforms:
         (CMatch("__attribute__"), ""),
         (CMatch("STATIC_IFN_KUNIT"), ""),
         (CMatch("INLINE_IFN_KUNIT"), ""),
+        (CMatch("__nonnull_args"), ""),
 
         #
         # HACK: this is similar to process_export() hack. It is meant to
-- 
2.53.0-Meta


