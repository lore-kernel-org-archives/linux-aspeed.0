Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19055606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=VVlo1g2c
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNfX6K7Qz2yQl;
	Thu, 29 Oct 2026 10:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176207;
	cv=none; b=O/gNNlsPAZ5rIHJvKhM+ouF6cx8NvxLSX/X4RL2vjwWgkABex2rb+EGLTVxY7rR5z9XiFh/h3Rq69K6ny8KgMnbSwpB7DYAfdn/SrOoomDftkfUr7GMQ+47rC1rBuv2QHwGDOQVH146ZpDdFmuI2rBjwNnZjkwpvIOpqrSvDN9r9FDpKL2WuudqpwyYbktrIbvvuKWDuoH3Vv0WTw74MXbfkOTj6DKrIAZ3jKlEIb56IYyfwnD1mWAarA89fXnloFbEy5MLysMMiMXbXJmF6MwCcoZgSrQpTlqo0DgOPcBC/J1HUJMMfFzBqU7ujJsFi1Q/Bn1HFZtPALy3qYwMRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176207; c=relaxed/relaxed;
	bh=FiKV5NXJkUgnsMcI+sXb0n0HNmp3jB2cH055fflH0Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDX1XwR+8O6Ntq8dDnG0WaH5OSFFGv/uWJxIUZW+pluVSqFO5H9y5yHXI4EAu3vwCBdb7TL4YT6AovcJMT++3w11cLSFGvxRDGYl3eX9anHjOVb1aFLVO0n47ixijeCgGRFrhaZSPWIA5VjYVpr0GjzPog6VVmek6Uw47jVV1DYjLCOM3qYyrUrjsvW0yci//LMq9pHb2JkuO0cQtIaENPW3KbTH4zSCRh0Kd6evZmIP42VkdPqGrgHpE3y7htOQHvUPqIj8kvAX12wkN/zfSnJ4UPYRV4K5aJbMGQbq04RJD4tYsuTsd+TgP7k9sUgA67LZJ52qAmSsmLyreDss1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=VVlo1g2c; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=VVlo1g2c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0sm4psRz2xwL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175636;
	bh=FiKV5NXJkUgnsMcI+sXb0n0HNmp3jB2cH055fflH0Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVlo1g2cdt+56K8mWNs+kTnpuMnj6v1NqMXFWNclXmipKK5Opz7hXWMThpTbOSgyj
	 eOL9BeLA9artebTwUe3aomW3AQpvt1PlkLxI2lRkk5FAhY0kJkXeOLwyoZBdm+iTWu
	 I8Pef11LheXSvHn1Q8Fn9g/yAIYYO1mDlqVjQ0aw=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E3709FBCFD;
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
Subject: [PATCH 06/10] drm/amdgpu: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:45 +0000
Message-ID: <d57489b8bec240794a7a8aaac6e1e3e0d78ea331.1793027261.git.d@ilvokhin.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8f0720a77520..c238564b4a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -307,7 +307,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
  * move and different for a BO to BO copy.
  *
  */
-__attribute__((nonnull))
+__nonnull_args()
 static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 				      struct amdgpu_ttm_buffer_entity *entity,
 				      const struct amdgpu_copy_mem *src,
-- 
2.53.0-Meta


