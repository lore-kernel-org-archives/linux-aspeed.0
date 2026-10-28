Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB860A2604
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/rRIOZz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF2br1CKnz2yDr;
	Wed, 28 Oct 2026 20:48:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793180888;
	cv=pass; b=Km/KzLVVN3qO6Nd/SLtqcjJo9rqaELnG8RRZpSW8JcEbjZ8eNeaoKl333g0dBXraQDXqn4OpQTrSfOzfRGPHenxy1jgu94+T7HGFFNl1W0c6nIMt3UZ41TrS00JibPrrkTi0D6pRV3KvSDRisE1rDiq4/X9vpeWWf6Qc73Ao5onQL1Isszo7J0Kk/oIzC34sWuRRlPcAOGokN2LGb3XsPEye31A8ZmnRctTaRc5FOAJe3bd2ONbwYVUOsa3jYhOuXEqDrSniuwnakek/Ix9AELocppPKIiGYnaj4GepycUponxH+8xENHeKGOkiLLfs49uF4UfBlJX+Oqai3TaOL/w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793180888; c=relaxed/relaxed;
	bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AceO/fCHEBUHb3t3QDSVDt1bbEY7YBb3ZVfs3r9LpcAB8a5WZMEO5bG1K8zc6c1pM0Tj20BpQWwJniVsbRhRjJXlDUSH4Hf+0nKBDvwG7FM0kUzaJNGyvE5Zch9oi9HEjAefllwLHEELJ6m/PrPD2n7Op486dhI/AbpAqn9d6JNb3oaJ9KwU6ScgYricY+MMvh8w75fmxrqkrfNqMlhT3U7XZBxJ+Tgdlbeqo1jjppzRg1VhGM6CjUy1lgCZ3CHdkHv5kMjIpiohQRVenEHAlfXjmBPVTeRxPEbFkTBru6xquEgOih1cZ9+UuyzDQDZvQOhSCwZvSvS5z1jETom4+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/rRIOZz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/rRIOZz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF2bp1wkLz2xlj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 20:48:05 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2862122a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 02:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180881; cv=none;
        d=google.com; s=arc-20260327;
        b=mneGGX40AsSCOw4smzptYWa6eyqII7Bwf/CsYjKE5IpUIjsgWIVDLwDmh1COCi98+s
         Mc72yEWgGvkK+GJPoorTf9Tzu8rftnsuSUxpM5+dKBeDHcoxcIgWHmIXklmVuRh3GwYJ
         zTIq77jW+j8GYJqDjiiFik/KSRJOgkzUhgiWmYJr0KGJJolN4Jw+yamq8KAeBZGi2NOm
         hwxxC/gjODaTrNcbIuPcI9Z9XjZ0gQhwg5cRCUbcNfVPIKfygiw3Zjy/oWxtyBXULtKM
         2/+15iRvfTvSqAIRPmyxkRnwycgR2oaskPqk0exEi85My+vSomiJzqm6ye3E9F4V22FP
         Op8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        fh=+I0M64y8RPKMk4pfajViia7vXxFB6tZNrPyWb3Qlei4=;
        b=B/82ECK50m/KD6TzSDozKRadiuzTmDXFR0BbXr/C/Xc5hDj2yWI/aSX/co/2AW9KAa
         7LVs9gEaFLzAKDHi12I28cojEKbnbPI+Yz713sAvQiK4yfi5D9t01wUFS8MrjJnb798L
         Vj6tEa2/N5sSiJQgWwj3hbjanoLHL31sHfLCiLSFwisZjFcWu4VGKSY/yab9Spnarusq
         Xl/bqSulqinNhGQni410EnRuUda5wKrl2+/cXGu+ZL9SnBJxPXfTF0k6Cy3Uv9efAI8j
         d9HerOQDZuAS5HBuDhe9YC9kUH79YWpGEcKU3Oz7adASuIZDGwj2q0Ho0NvHeyifI9lv
         cZuQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=l/rRIOZziJY6bIzSOoKa0/+0kgdszYaowna+hOCG4CxULihnP8NyuEX9KBzcPsseRo
         TsALBHNR8bp4dnn+vsqQpygR9SWCiYMSwYGLm1Kc00Q7sXvrxp3PD85FBVmQP3kLJVfm
         wVA5W/lAuMJCAyTq9+QNrQvbLBTs7laS4ZakB1Gk7FhHoLyJaRhZaKmBqzmT4ha5DGkh
         eSAvqF9tTdqHT02+4wTJIXIDOIdhlqnSsS2dK99aPi3Pqc5s3PkoJxNoWJ+F14+DMRS6
         iANGxvOSjEkapmjm1l+HJ5ulrlkqgpgT+wJqp/Tycd6yxwHbZzbKhdMMTWuzyR5qw32D
         jmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180881; x=1793785681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=kFe2V3UKbUumCB6AzEQg4pa++jLHb2KoJbKz1EuT2cvV3U+OVty9FyOKS6+Iuq/93j
         35c3UqLXuRoc887rED6DP90YMWdRCG0ANZd4612ZamJ0Ueswumr1YunkiaaGNYVTexpa
         HhcB7P7leLcHrp2jdKJruQZE0FoOUlV1G7h5MDJNN9y5Zt7LpaP/pg7b5dJESoPZ4FRs
         Cbs7EYoo5Jwtl8o4mFb4wXaD7+V7AuNkbBzU/5VqIMG1ZShQFUG4ezbdOLY/UesgnPRC
         DFdxREf+kaIelu2sTMs6HTTB4IDuzV+dkvjDqjJwXe3zXWGUQn/4sNWz9EDb0Gbtkg8Y
         J8GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxelWoxXIyZvs+u+p7BsDWEuD4UsLioQH/B4g0twfl6R5zAfYTaNRsKnnGbjToo19Mi1T0peTnBHQDnfgk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKnYtwqi9I3YYM7bgt0+C2l9OZNiMyLrubon8cttUENEykCBpxR
	gTFjzVvD0vQVLmpWaiB1qqQuvnXzLCDwyH/cyjdi68gMsrAHgS9LfldNEFSCfgaCtlYsCZG/cXY
	GfWG3HWPBzMmXrA088OW+TaUxKEq8pTg=
X-Gm-Gg: AYBFou0kMYP22rSn5DGaa+GHA+c1euBajUtb8MW86VYYEZIYB0iu96yvG4N1ytt0iWF
	0+5bmxLWY3Pbvq2RXEeCzzj3ZMEgONGCCsYJctqYyUYU+RtNPPZZ3LUA6djHM4PSz1NYDHWf17s
	Gmtgeec4gSAksHX7qws3Zkq9fuNoZhXwQ2ShVaRDgW2Z4Zt9L4mgqwNTWWBVwP7yxl9ecZAmzRy
	B0NQxX7uKXz+MWyKJaFZmqHl8sYGhCw+51B4L32MkLbYPXXfRiIQI4FIZgCWGv1LRco3Ur/ciPR
	BBmASjpSM+jU3ziBh1LQyCPXDHiVYNwZx+03uo4vx+zbIXbJKzeFj4iH7MrEmFmQdCiv1QKQgOP
	jS66AOCria0QU67b6GyWDBhd+crhSazj88ie3MNWfKk79j184r1L6hZRH655hkfotrpsG6UFqUI
	ttVXUZVng96wWCrTZjhXVOngLWSHN+ZT4noGtyT39/dI12Ctd4ZAeeRcr/byRTLmXyP6Etw+zku
	QLVPxuGFmdxharH8N0MhePz5A==
X-Received: by 2002:a17:907:86a5:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c49c6357d34mr69949566b.18.1793180881026; Wed, 28 Oct 2026
 02:48:01 -0700 (PDT)
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
References: <cover.1793027261.git.d@ilvokhin.com> <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:47:24 +0200
X-Gm-Features: AclHuK-8N84O0Y9k-BLOPVpeywTja7886uZe3ugxN4eM-96m__IvC7bzZgS0MkU
Message-ID: <CAHp75Vedr5J1WJMrAkBjRSLKA_zf1kt3GD6UhjzLcy9vowxnaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.
>
> Add spaces after the commas in the __nonnull_args() argument list to
> follow the usual coding style (according to checkpatch).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

