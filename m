Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A9606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW4NmbXM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF5Bb5gX4z2yDr;
	Wed, 28 Oct 2026 22:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793187895;
	cv=none; b=PMQDcR7Y42ADlttu7aQfI7G8WEPz7hDeCInpkd0pCfo+Gnk176m7WPw5F/GS6JuoaOqz4S4DmaTHL2ZK7c4KfDD4Uu+H54bIdqaTW1iscxgm4rzbEjvyGhXGsT90frYPvvTNKn+4eeW2dj4hegwzaq0gCSNopEgDCPnQFEvehthSDz+FLHqLLsbsPQYCAB8VFhq9PK/gmkHeTVa9y4g2j4jy+9wLwby39XTjb7LBqzUOHMWDHWRtV6JgnIx8b0dhXr3969+RRAEnl4i9GgvnTNirD7Zv+FW0xxMW8919XD7k40cKLqWUkrbhyJV6Wd3J4VvakrIwNCtlxqiu077uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793187895; c=relaxed/relaxed;
	bh=AzxsreGIazEGHNZ+Tlba7bzQuuS0/SXodByMLbgqMaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJtUrgR+s5cj1EbgtgRtDpPjvM2YX/ZAjoyBfolTxY/2mM7AIZP9p7iqx92+Nw6kRG+TJ9jsbayK10H+JGnbZ3qMAb/MTZeiVpofCdCt/pdM+QLtk81ZqcKM8q98DANS27yIzRLihHbbXIb+M8IUpuCer5V/Su6SIcuh+PNIy/ldj5W17FKEBZSzsi0npAKKli6YQNAA7ejOB4an0iASm7FQ7OKa1u5AndTgaKdLFj3ttAs9+T7ijhd2l9i08LPmc+24EE0KZnsTp/1G2dYbSQwjVEKqNwZWEEBkXZzBi4xdzXZ4omepKxLQmHpDuCEQ4QK1d3qy9MbKI1sSfcocjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW4NmbXM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW4NmbXM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF5Bb0s3Zz2xB1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 22:44:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E10660120;
	Wed, 28 Oct 2026 11:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7167F1F01825;
	Wed, 28 Oct 2026 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187892;
	bh=AzxsreGIazEGHNZ+Tlba7bzQuuS0/SXodByMLbgqMaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JW4NmbXMV9NgnBU1HlqkVlN+rre+4AqJtfnOYsCrZ1r+jx0JuneNnyHXtAgbJhcCm
	 oGoH7Sf0QLhsPHYJ4VS3tj9kTxIwtUgUtfQrlW3PBdn2exn76z9iW9PGXPGM7wzI9x
	 At4s0hoSb59+TSET152LixjqCST6NybH81zHXNXle6qHlbYtt+3P9F/grboN9LPDNx
	 xzflTm1Ec4mh4z9eI8VLirREUz5LLnYViE+P42WUDgoR0QejsFy2B/B+DLWbjrllQj
	 91G7GnwWDaZoA9reF7WmdaYzo1PUQd8JuF3UHtJOxu/4CYIjVpedfBJtBtUN0pf7S9
	 lIU5MaIshhDuA==
Date: Wed, 28 Oct 2026 12:44:48 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auHgHcU4fYauP_eD@zenone.zhora.eu>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dmitry,

On Wed, Oct 28, 2026 at 08:19:46AM +0000, Dmitry Ilvokhin wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
> 
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.
> 
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

