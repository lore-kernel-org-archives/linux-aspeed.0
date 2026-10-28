Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACC606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=scmphY3W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNfX37qlz2yMn;
	Thu, 29 Oct 2026 10:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793176206;
	cv=none; b=FZJwtgZnPc49RLOMYZT+/rJ6JUI2Hg6apxy4C2j0yMYqaDY39o+49uqOmdBfPpKeVBqNHKYTwQPx7A76j42ftykf1AmDqifUyyoOTEpwySg8kl+MLra4jsKxa3g+uBd34kVZD0FpGCuMwYRhxk6ov4zgRxEy15mfEFZMS2L4rQWlnr8fmhKSyYfMtJwgH8O+Ddlh5eJefme9wz8L4Zec4rBbeEL+EJ8d13mbIO0xVWlGTMmEDQp9/zP7l5E8N0G2hRF/B+RGAG4Q+SmLut6t0afAi1SM3uPJJcy3dbiSFsVP4c2dzluK7xF1JrY/85sx2x7FOjODyptlxCaTrbGTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793176206; c=relaxed/relaxed;
	bh=K5LKyQgYKwl4SQBjA15TdSBAX9bbXAc3tVQHLRXEih8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAjD4H/mNdTLQEtD/Ad3yB8MoQkEvZkbJAV3aa8bGl2mW0sPBIgjPmHCQHicECh3CeGMbICbpK77ZH16LhbEACsXAq4PogCEgTcpOE8KlHBjF+ra8DIdgcZNZLuUfIKzs4MjsCZlQaqYDUW/wEDcUNVj6+CBDi8GenqnFqinyNBbbOXEjWeU+qtJu2YrEQywwwZS96LDP3NUQeVwezEP5gc3A/WK56O+yw+6ojUj0CLT7ikrZdViOoNavfWCYlzheqFYenCfLQu2cK5/hR3W3NdbH9aLP2Xnhr5k2bpxmfoTbMepH8DTtDlmW2EzLmSfIPhv2oueV6BkRDWwbjEfrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=scmphY3W; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=scmphY3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 567 seconds by postgrey-1.37 at boromir; Wed, 28 Oct 2026 19:30:04 AEDT
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF0sm1qq4z2xPB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 19:30:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175633;
	bh=K5LKyQgYKwl4SQBjA15TdSBAX9bbXAc3tVQHLRXEih8=;
	h=From:To:Cc:Subject:Date;
	b=scmphY3Wunrsmp+34WEVPizPYNuER4OuyqQN+7wcAk8b243s6Ql6ZgZzt2Q3H2Zn3
	 fwtCXvfv3lUFbjuEGdD5xIfcK8QirvUz/AoB8DzMfhdVnF9ZGl/3QyMwT3LvSHQOfV
	 tYEhcDcVdgbtrWL1qNZRxMyUJGS6xrDDGVIAFe9A=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E3225FBCE3;
	Wed, 28 Oct 2026 08:20:32 +0000 (UTC)
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
Subject: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:39 +0000
Message-ID: <cover.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the __nonnull_args() macro to wrap the raw compiler
attribute, keeping the attribute's quirks in one place rather than
open-coded at every call site.

This series replaces the remaining open-coded __attribute__((nonnull))
users with __nonnull_args() to standardize nonnull attribute usage
across the tree.

Each patch can be applied separately by the respective maintainers. The
only dependency is kernel-doc: the string and lib/list_sort patches need
patch 1 ("docs: xforms_lists: support __nonnull_args()") in the same
release, otherwise strends() and list_sort() drop out of the generated
documentation.

Latest Sparse release could not properly parse __nonnull_args() without
arguments. Fix was proposed [1] and merged, but until updated version of
Sparse will reach wide masses it might trip on __nonnull_args() without
arguments.

There are few more instances of __attribute__((nonnull)) usages left in
the tools subdirectory, they are perf related copied files and can
(should?) be updated separately after this patchset lands.

Build-tested allmodconfig with GCC 11.5.0 and clang 22.1.8.

[1]: https://lore.kernel.org/all/20261019175633.415493-19-bvanassche@acm.org/

Dmitry Ilvokhin (10):
  docs: xforms_lists: support __nonnull_args()
  string: Switch to __nonnull_args() macro
  lib/list_sort: Switch to __nonnull_args() macro
  xarray: switch to __nonnull_args() macro
  drm/i915: switch to __nonnull_args() macro
  drm/amdgpu: switch to __nonnull_args() macro
  drm/gem: Switch to __nonnull_args() macro
  leds: pwm: Switch to __nonnull_args() macro
  soc: aspeed: lpc-snoop: Switch to __nonnull_args() macro
  checkpatch: suggest nonnull attribute conversion

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
 drivers/gpu/drm/i915/i915_request.h        | 4 ++--
 drivers/leds/leds-pwm.c                    | 2 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c      | 4 ++--
 include/drm/drm_gem.h                      | 2 +-
 include/linux/list_sort.h                  | 4 ++--
 include/linux/string.h                     | 2 +-
 include/linux/xarray.h                     | 4 ++--
 lib/list_sort.c                            | 6 +++---
 scripts/checkpatch.pl                      | 3 +++
 tools/include/linux/compiler.h             | 4 ++++
 tools/lib/python/kdoc/xforms_lists.py      | 1 +
 13 files changed, 25 insertions(+), 17 deletions(-)


base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.53.0-Meta


