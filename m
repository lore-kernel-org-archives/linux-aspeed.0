Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE96606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=fRqV9usC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR94s5tz2ygg;
	Thu, 29 Oct 2026 10:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176210;
	cv=none; b=B2qFZDQUOVTpRHa+08QinWAu7CZ6tKhxridcu5pLGrsQ0xgV2QzJ1nPu723Ec98SIQivxoFFUUJMmgvCgoMRm08LtIHIeX0oAsKPlB925bHf9H9MN5+k9c3vrrEp28X/RT4OIJExDTxDdoyXQIiVFpcQIJjoloZz0VlTkPTrlBh6brljJQ5WU64AYsrqU64+jYHqDQtZGZBH0gxAgEOudKvllC1BdorD1cTW4VqON2QreIxyYsxxn3m3eAFQmU3/ZFfuR7lbpnPOlVDBpda+WYPAmhX8rMGzUJpD86Ys1uZYtPqYuKfH5affJPXqBcPwOnOIPwXaypQY0TofpGpLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176210; c=relaxed/relaxed;
	bh=AdVY/3WZr/KgFPIGBWq+6cOVqwnT9WYPit6o2kFUWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+Ra2cLHtUMrK0AOf6ZNWP/GcMjn3rXiODf4KwlFqD2MG+ET2MIvTWi+a/THVNFyr6h/G8acknI45cA6leNd14Eo4STyIe+mkTFVWFnkaYl0MfijqSfovmgK100+x/EGicXOFX7SgCSuH4QW4YTsAhSxprArjEZGuAm5yI8T8gKxzQUuA1VPhUQxaVMy/nXkuKOvdpn8uWNrpJsCPMipDeJ2Z2z4qVt7e3ieeAXrk0a6M6QIyhef02stZuCb3YEsGd2iD60i0OqidECSH/f7NUcIA1e9bqzJ7h6UwdfvonJAJMYcZpS3umGcm/DedQn2DuVhjwg4XsP62UOQzEBbGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=fRqV9usC; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=fRqV9usC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0ss3kLlz2yfy
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175634;
	bh=AdVY/3WZr/KgFPIGBWq+6cOVqwnT9WYPit6o2kFUWLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRqV9usCJkdMBWrlhWbddwDwn+QiWrVuXXhlmM06WA8hyjUwJjBOQD3oUvn7U51hA
	 cz9ypprvSW6rwhpGQQm90dgUka6nWyEZzu4lfjwdDuK2/cx66TCGAU3CwyclW84k6b
	 EOioxvCx2Rj0sgA/zgEBxG2IHQAcr5/J9BnKuTEI=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 65391FBCED;
	Wed, 28 Oct 2026 08:20:34 +0000 (UTC)
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
Subject: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:42 +0000
Message-ID: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
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

Add spaces after the commas in the __nonnull_args() argument list to
follow the usual coding style (according to checkpatch).

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/list_sort.h | 4 ++--
 lib/list_sort.c           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_sort.h b/include/linux/list_sort.h
index 453105f74e05..48a91ef0d751 100644
--- a/include/linux/list_sort.h
+++ b/include/linux/list_sort.h
@@ -6,9 +6,9 @@
 
 struct list_head;
 
-typedef int __attribute__((nonnull(2,3))) (*list_cmp_func_t)(void *,
+typedef int __nonnull_args(2, 3) (*list_cmp_func_t)(void *,
 		const struct list_head *, const struct list_head *);
 
-__attribute__((nonnull(2,3)))
+__nonnull_args(2, 3)
 void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp);
 #endif
diff --git a/lib/list_sort.c b/lib/list_sort.c
index ff99203f208f..da34c46cf5d8 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -9,7 +9,7 @@
  * to chaining of merge() calls: null-terminated, no reserved or
  * sentinel head node, "prev" links not maintained.
  */
-__attribute__((nonnull(2,3,4)))
+__nonnull_args(2, 3, 4)
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
@@ -45,7 +45,7 @@ static struct list_head *merge(void *priv, list_cmp_func_t cmp,
  * prev-link restoration pass, or maintaining the prev links
  * throughout.
  */
-__attribute__((nonnull(2,3,4,5)))
+__nonnull_args(2, 3, 4, 5)
 static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 			struct list_head *a, struct list_head *b)
 {
@@ -175,7 +175,7 @@ static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
  * of size 2^k varies from 2^(k-1) (cases 3 and 5 when x == 0) to
  * 2^(k+1) - 1 (second merge of case 5 when x == 2^(k-1) - 1).
  */
-__attribute__((nonnull(2,3)))
+__nonnull_args(2, 3)
 void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp)
 {
 	struct list_head *list = head->next, *pending = NULL;
-- 
2.53.0-Meta


