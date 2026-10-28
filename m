Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA82606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR86M0Gz2yQl;
	Thu, 29 Oct 2026 10:11:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176210;
	cv=none; b=D6SeKORhtk46oKWNXSUjrKveyfankYr+47nhLQo3PIZfANJSJuajt7ZYxHHprunLvd9VlJ7JjLVSp08GjCFufXDh1QQQZ3oLQ3uH8F7/crIsrd5FqHE/kndqozjXX24T2RFuSvzUvkcgV75B6lSaX1wBgJ5USXrEvRdjMKwsmYAHHuKq9vffh0yHgFXoBegSZBn5pwOOO8n0WgkU6YgnVw6HEsDwpJRCbYQZwgiQRJ9L/yVNrZYY6q9eNDjfL4Ww9etmpRpnxG4WRBp35hHDo201x6KLJ/WtDXGhun7yPol3oybp4WUE5nDedSGzMtKkIKexHZXYX0+RY0e5H2h9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176210; c=relaxed/relaxed;
	bh=dWJJn/15+ghgzzIGKgM3IMULkpSh/eugDFHemmlBRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml+GLd5aGjibNlypB1gKsNIgCrPiuOf/43SCTOh3rl+AwplEAEgS3WKeLRjh7RPg+SaR08In/l/GS8whv3qa8IqS/JQxpUMMPq/pd7gLpyAsxml3sAZiPBeXHgH3tijHFosfu5IIJCDjXuNAJc64LcbzfoTKLuZxWKIEL+GHubxxQdZTL+641lzE42OXgUHLFcelFWOjkrKsu93rRBdIuFxQxNslu9c2Z0UMlGXg7o/VNAg+p/xTwzzH7NN/zxaWOILd8RbsbyqHNqyi09W83mH+09s7WuT5wNQIBqU3YI6sL0Jxr066/NwO6ANjNN63jeDSer5y3p0R5Qqr+jFiYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=DeIiv9WX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0ss3gl2z2yfs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175634;
	bh=dWJJn/15+ghgzzIGKgM3IMULkpSh/eugDFHemmlBRb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DeIiv9WXQV3gD55AucY67CXV5GytqfXEJkOIlH/p1vvpmEBa02wb0CiZ7FetKO8kp
	 vKMP3WYwznobDJIR52jidVzMPZfhGDf6UWW8grvqXfGJ9aPtokciLL67F0nlp74wpP
	 VCbSuHZCHz4d69J6NRvoiFKB6uqBPcC0poA2OXFs=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DF86BFBCE8;
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
Subject: [PATCH 02/10] string: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:41 +0000
Message-ID: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
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

Replace __attribute__((nonnull)) with __nonnull_args() to
standardize nonnull attribute usage across the tree and keep the
attribute's quirks in one place rather than open-coded at every call
site.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..1f1cb73514e1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -587,7 +587,7 @@ static inline bool strstarts(const char *str, const char *prefix)
  * Returns:
  * True if @str ends with @suffix. False in all other cases.
  */
-static inline bool __attribute__((nonnull(1, 2)))
+static inline bool __nonnull_args(1, 2)
 strends(const char *str, const char *suffix)
 {
 	unsigned int str_len = strlen(str), suffix_len = strlen(suffix);
-- 
2.53.0-Meta


