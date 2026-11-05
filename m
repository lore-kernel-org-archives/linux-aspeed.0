Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF0606D822
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHt7HSGu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL47S4Z4bz2xN4;
	Fri, 06 Nov 2026 01:14:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793888068;
	cv=none; b=opTTKgMk/5HFbqRT9rXI8dCIChJRMSt/QP+buZLcqmIXP/35Ir6wg4kYCa/NT1217OADRZaK+FZKMCE5Vw9u0YvEWdL6wysdqAabP/B+1od+Lp4+VX0zHqmXyCjst+Py6oPQEfm4nzLbGJBQcjkX7LtGB0ssuLX0Mtqy4E4xuq40kyUNX9uSAgh4LQVxbEpm4ab4VHHS+vSmRU8VqRUTJSN3wBUS6BzdOBE3oU+o7+05HbjDPFpdmsPgv2NiTBGTPDgCGMhn5ILvfvibW5d33MHdEX0u4tS/CllzNMfcozQbA/jxrxXfD78e1HgNVoojjr4hMT6yCKuc28Dv//5VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793888068; c=relaxed/relaxed;
	bh=4QpYJSS9gn8AjXi8jX/3Dtqw7BlVuFU8dH7dnogBVO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IayyueCnri6tjADvpUX27kONjFzXIkk48o9eDyZIJSRxpmgdGnoYpp4da+9m+PNgls4h3BUA1wXTKudjUFlyhW296DjholW1y0bcXtxt0cseW5LrFjn46/2Mg83xGgvXxhqbRB11nHrhgcpvS8lpH6NzNg4dCnyMwRZsQvakSP8Yj/vc+c11/xQUnrEBYZbu9E/7K3Lu1ONHOtb+GR9BHpk3xWfJy8FCIxIzfJarh4Ln5JgOos5l6Ig3th6gS2l36M3tttlh8QmKYCr+ZVjMzVOEwE6bVl2WLEyY5jmHttrcm0Pw9qEFcsWk7Z2yh/q9hNCwJRIYUS07dE0cZofpLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHt7HSGu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHt7HSGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL47R6r0Hz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 01:14:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84A88438DE;
	Thu,  5 Nov 2026 14:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B311F00A1B;
	Thu,  5 Nov 2026 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888065;
	bh=4QpYJSS9gn8AjXi8jX/3Dtqw7BlVuFU8dH7dnogBVO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZHt7HSGugybN5tt7aBm2DYpjLqmVSzGHPf+FbQmlOA5T4Nk5fCKWzCEZb+J82PHlw
	 l6AVe6kDbgKPpfD8/3R3rRcmmEPrg353sNwySWNZPUaC8eFmRslm5bIRcVZkF6IdyU
	 ruk1UXsR2KoKlIyaiX4m5Bt2MaupvTmPsJkjn50vKnSDxBeKsVV4bwubvy7qds1fXh
	 dHtWj4Z4lh+pj2d8Bkkjb5jAZcuLTyb0EPvvsrr0CO/XIRBV5F5Y3YmW39L6T82LYq
	 MDqcufEATybJTn1bGcMM2j64t0KtpUgUMcx8vhy/hXPFsBB7xQM1sVp6uE3gUGspMg
	 8BTqLnNf590eA==
From: Lee Jones <lee@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
References: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
Subject: Re: (subset) [PATCH 08/10] leds: pwm: Switch to __nonnull_args()
 macro
Message-Id: <179388805861.2575351.14283088205507759337.b4-ty@b4>
Date: Thu, 05 Nov 2026 14:14:18 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 08:19:47 +0000, Dmitry Ilvokhin wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
> 
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.
> 
> [...]

Applied, thanks!

[08/10] leds: pwm: Switch to __nonnull_args() macro
        commit: 687615faae92e36a2b6c5ab0d007751e8e88a645

--
Lee Jones [李琼斯]


