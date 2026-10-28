Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DC606A326
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uwiMqCzW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFKBJ1PRfz2yLY;
	Thu, 29 Oct 2026 07:45:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793220328;
	cv=none; b=AVPW42v8KdR67lIN2B1keC9Zed2M97XviuKcZCL8otDAJjHFqrXm1QUHdYhw55nmgjm6xSFJtzL5fr09AeSXINSQNVtPwgO7H9BBg3a5fUPmbet29p/PbUBYSoqL4rjZHSaVw4IN5kp4WHXLCRLEH/kS3GeKTWs4uUvp+ep/GElZpgGsaEElGCOdnOGfsliCzElXV+NTrqSXDBffVvSCE6OPm6S48r5f4wAG7iVkJlVcwNTdvCLtVZ5rYNyYW53+62M5HOPHcR62ebm1ea9B9CchryZR8e6BYdGnNW6GpTTi+EyFVtU9C/IVH75xsxh6mSP4IQcUXQn/mElhoLrI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793220328; c=relaxed/relaxed;
	bh=xhSU0Ll/YflHcbTsaPvMuTReTRNyw9O7ljUv0SFKW4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1wJjKhnqclxDl+OwIvP7mpqKu206U1uVaJ0lEx9g4wVKCcJrsz1ZLwt8nzD6N8JtMDPZJxYoSZKW1cOBDGakh6yCSJ+Y5DJnhMEL073icx5iNev1wcWS1Oc/p6CtQbQAkhTcvi4dcsWdWHqmcalgMmrsIL5gpHLYqbAVw7TyvsWmqwGwJPLpqYzfydzgvvU5cuCv9SR1vgxsMPSVRwdSKxoiSihcdSZb6RQ8N0mFhr6IurpJ0ei27hhQPRHpLm8BX564IbBgbP+xL5mfe2Ml0xRV5jycX1B1dSxZI141DIZlDTACXvWTFnrOjA17PIBhVyQAVcf7iGSNotBqVC5Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uwiMqCzW; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uwiMqCzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFKBG5bWzz2y8m
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 07:45:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xhSU0Ll/YflHcbTsaPvMuTReTRNyw9O7ljUv0SFKW4A=; b=uwiMqCzWxlSLOyvJWx1EpAyUkI
	8btbBfprVdCDyHYW3PydxYRJfRc+kFnuoObOoozn1rwW58Vj2BVWhqh0F+wlp8xlwih90BYwI51Em
	K1iI2tMdxPVFIWoitj5UhzFd4b/5QNlPTbdXz9zJMTATbRVGeZUbYvxryNKsjaEpApTR2/Y1wym5S
	RWkAgUP9MihkaliXEWdKo6u9MyrEOFdwTO3LSL1qUppz7BzJah7zzT1oZKKj6Mf9SU1NRxYMWkfbQ
	WLJ0+6zjDTz5RuWWZ/Qmx/h26GtaT+lmVMT47+gjluaxiNFrhSxl9AUI43A4wXxL3uIkD/jLlvX82
	Gvlz4IVw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMAW5-00000007wax-2Fqn;
	Wed, 28 Oct 2026 20:45:01 +0000
Message-ID: <cce30180-c1c4-4b10-b681-8944057bc698@infradead.org>
Date: Wed, 28 Oct 2026 13:44:59 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] treewide: switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft
 <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <cover.1793027261.git.d@ilvokhin.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/26 1:19 AM, Dmitry Ilvokhin wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the __nonnull_args() macro to wrap the raw compiler
> attribute, keeping the attribute's quirks in one place rather than
> open-coded at every call site.
> 
> This series replaces the remaining open-coded __attribute__((nonnull))
> users with __nonnull_args() to standardize nonnull attribute usage
> across the tree.
> 
> Each patch can be applied separately by the respective maintainers. The
> only dependency is kernel-doc: the string and lib/list_sort patches need
> patch 1 ("docs: xforms_lists: support __nonnull_args()") in the same
> release, otherwise strends() and list_sort() drop out of the generated
> documentation.
> 
> Latest Sparse release could not properly parse __nonnull_args() without
> arguments. Fix was proposed [1] and merged, but until updated version of
> Sparse will reach wide masses it might trip on __nonnull_args() without
> arguments.
> 
> There are few more instances of __attribute__((nonnull)) usages left in
> the tools subdirectory, they are perf related copied files and can
> (should?) be updated separately after this patchset lands.
> 
> Build-tested allmodconfig with GCC 11.5.0 and clang 22.1.8.

What ARCH(es)?

Did you mean to use such an "old" version of GCC?

thanks.

> 
> [1]: https://lore.kernel.org/all/20261019175633.415493-19-bvanassche@acm.org/
> 
> Dmitry Ilvokhin (10):
>   docs: xforms_lists: support __nonnull_args()
>   string: Switch to __nonnull_args() macro
>   lib/list_sort: Switch to __nonnull_args() macro
>   xarray: switch to __nonnull_args() macro
>   drm/i915: switch to __nonnull_args() macro
>   drm/amdgpu: switch to __nonnull_args() macro
>   drm/gem: Switch to __nonnull_args() macro
>   leds: pwm: Switch to __nonnull_args() macro
>   soc: aspeed: lpc-snoop: Switch to __nonnull_args() macro
>   checkpatch: suggest nonnull attribute conversion
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
>  drivers/gpu/drm/i915/i915_request.h        | 4 ++--
>  drivers/leds/leds-pwm.c                    | 2 +-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c      | 4 ++--
>  include/drm/drm_gem.h                      | 2 +-
>  include/linux/list_sort.h                  | 4 ++--
>  include/linux/string.h                     | 2 +-
>  include/linux/xarray.h                     | 4 ++--
>  lib/list_sort.c                            | 6 +++---
>  scripts/checkpatch.pl                      | 3 +++
>  tools/include/linux/compiler.h             | 4 ++++
>  tools/lib/python/kdoc/xforms_lists.py      | 1 +
>  13 files changed, 25 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a

-- 
~Randy


