Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2F606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR21TF5z2yfl;
	Thu, 29 Oct 2026 10:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176210;
	cv=none; b=KM2Bw1pglMubUBSW46513cDumYaZH7EOky3xZ4hpDLE8h7jqQNnHsAzxHIKlYS/mk44KB1FLgnDjuDjXT6brM+ZLmrn+0fZM+d/iX4MaaZGP2oIQPnPcuhJAGUik3pq8DutsF1DNCKxGjYGYHVJnqxUP9JsVXHPSEsdmkkSJpOFRLEkTkd5BubwzteA1aNHPKcyL8sZq6NKUa9tpKyjuUbqc3FoTOINSi1bQW81pQazl+xW/UOLbIRuiNz0v1VGJgh9qJDZtZeoAWYy/KSBbH7qoMwqLnuZRzshpAJlCtqsbnoxLOgZvs2calmAwIH/iOVB/VSoYuPBiMdIJQoT2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176210; c=relaxed/relaxed;
	bh=gVqyFTfbEx0Cy541rHtX1s3lHEBCWasBv5wrEWGFtiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuM0WlXSjUXTxBurj7rdzyuWOFZg2jR8LnqqUl/8w4H3dp+FExgzc3Qp1H4cUpgzHKuYK3PLFsBWkmQnW+r/6RkRSzByLn88nJDlqvfUXY2GavK4G/JNMJfaRvfTIwq25fWQ6i2UytzzkQ2SW5zhemLIxX6+OBQMcAbs3fRm1ARJh5B/nzx4zC5PJc7faXfFXgpAN7xzFPxbJW5r3Vba8nx5AWTxMDwy7ytdew1qT/RLhgL6S2nzpsMWtx5qm54njE6G7cBmXWUXpoeRml4jNOlBq7J7k7skZlt8+rRUiEtgY4BR3HL45gQeimgjWOvvePTzJ8veehjxxw/A0M8k7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=zSnSDJrh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0ss3fBcz2yfl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175638;
	bh=gVqyFTfbEx0Cy541rHtX1s3lHEBCWasBv5wrEWGFtiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zSnSDJrh8lBPc+WJwkieuUvYZceHyW7Vo/Rgps/0sKKYfp+K8gQiq+VtATPCk1zcM
	 2R2y4VPojBg1miUzjCPiX1c/WXoMhA0i7UdNieYWkQzNjxxQaVUfA0XDy7P6CuqIG8
	 6OdZZd54748+SoGV6+XeC+xLbbD4RuBe2dmrjidY=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 232FBFBD1C;
	Wed, 28 Oct 2026 08:20:38 +0000 (UTC)
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
Subject: [PATCH 10/10] checkpatch: suggest nonnull attribute conversion
Date: Wed, 28 Oct 2026 08:19:49 +0000
Message-ID: <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
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

The kernel provides the __nonnull_args() macro as the preferred form for
marking pointer arguments as non-NULL. Add a check suggesting the macro
over the raw __attribute__((nonnull)) spelling, consistent with the
existing attribute conversion suggestions.

Examples:

  WARNING: Prefer __nonnull_args(1, 2) over __attribute__((nonnull(1, 2)))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:230:
  +__attribute__((nonnull(1, 2)))

  WARNING: Prefer __nonnull_args() over __attribute__((nonnull))
  #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:283:
  +__attribute__((nonnull))

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9840f5219c2..e696fcd02337 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6856,6 +6856,7 @@ sub process {
 				"no_caller_saved_registers"	=> "__no_caller_saved_registers",
 				"noclone"			=> "__noclone",
 				"noinline"			=> "noinline",
+				"nonnull"			=> "__nonnull_args",
 				"nonstring"			=> "__nonstring",
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
@@ -6876,6 +6877,8 @@ sub process {
 					if ($curr_attr eq "format" && $params) {
 						$params =~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
 						$new = "__$1\($2";
+					} elsif ($curr_attr eq "nonnull" && $params eq "") {
+						$new = "$new()";
 					} else {
 						$new = "$new$params";
 					}
-- 
2.53.0-Meta


