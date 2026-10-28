Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97377606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+sTGeHY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF2cp2M23z2xlj;
	Wed, 28 Oct 2026 20:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::632" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793180938;
	cv=pass; b=YezA/qUg927ismGxR+mvtf5hri1ae2ABO6qg+bf7bVZ5u3TMUWsBQfbVG7col9NY+LIdoVw/9VteDZGy+g0a7wMcWFStVLxZhVbiPiLhUB8jwf59G5tpwPwIkPVmi2RIXkD2OZ2OYW6/4Z3f317y12OhXMSh/WfzKnA20PDY21nmegeGyi0qFz6N4kU3EYyxVylwK1om6PDYNx6YjYWb78O+xloWvikGb30zB65VOIN2Vbungm0sPLtN8iKKUqIxmUJ6YRyfjzUaTyv57X2EL0q0KNP+FfLqP4G9+EiFIQVRWadVOQ1s7ZjaIEJdKGjYiKyXJ1wdaOZ7G/JO2D4o2A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793180938; c=relaxed/relaxed;
	bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVhv/uCzD+xY3xiFbiWOH/46ZxF5k6zvFFQdzDJQqg/E63TZE5rBJ6opFuIMHn72Dm4wCtHAzEor0DYmxk48/aogV6Xqa3jKyTLaLkNVxW7hyI+6HYZ20ud/bvq427rxH5UHr9Ga8ovaz0y+en44H4UJctOwo43iqe3BNhez8bqHCVjZfaHsXXu86BDT8RM7aN5xkR+seWr8bnlMHJfKmDmWjP/RLKjEkjVvGpyzqf8NpcaJVjhbj+UR7OwwjaBK+wgyMHtKkLO5jVhqXM1X+UqWQDPeMAl6v273BmJXRzaXX874PeT9z+3CeXeezVk8D/nlZKDPAxwxgf6ifelerg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+sTGeHY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+sTGeHY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF2cn26hBz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 20:48:56 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c46d41f6af3so102026066b.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 02:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180933; cv=none;
        d=google.com; s=arc-20260327;
        b=emcRwMONW8dgUBKgww7CmX1ULsXj/OxuPKr6+d9qg05A6G4dVyuBsExb6KxOyE9qXw
         7BhGjbNB+jSCRXuDwuELf0ViWH+bW9XPlv/JsqLPG6XVG6XM5YJnTnyJNF4gjEIAtzxd
         nNnck5Wc5QGB6KDCXDt4x8CBK0OuP4PIOTd0XHe6LLAwDvV3qlqZ7Vgv6aSM+6IO04+F
         Bfrd6cYBLlEjY+LGEofIpNXoBpLBBUMb4E6MVlCohU0G3f+Wme203+Urm5ssQX+sAdPk
         ii2M1V1tbGv8ZuUv0GcPY54BFD8hqOrzf3plPnElwWxJRPRdlfr3Ibgr0SSeureN2PBB
         bcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        fh=TRZDPpqptTI2zOE+r7kLdT/fg6gKt0Cxte1JFAmzVkU=;
        b=l64DU6IDpToc+JeFd2CszqfSp2ZSgJRGNUvIAui1LNaE7AHvOAtIt6yUmS+MefF6Ld
         NxhyjGX/x3GFKQ5VHTCdCdRuGbC8XHgViRZcR+Qj4VhU1kk+qHRfBYITp12+/k13ADcv
         sdbZ8m5MYdb3A7Vollh3FEFFhQG1YId8wwBoL+9eV2tpZi+/9hslXceursX6FAzbOQvN
         4pqRS+LP9/wrgUzQXgyme58bnkLvr/gKORxMcmJDgTUgBEt6EUTiTTnLIg4TaTbCACSb
         C6M7cqQG/YH53aVyO8iM/S3SV0KURMpZFxMSxCtIktet+fpQYrYRFUe4xsChbZVK6Upl
         QrcA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180933; x=1793785733; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=a+sTGeHY+x5wzOxbOTs4Or+iANVlhcv9FW8lUQiBplW1n2uFcUoRGtWV53svnsCnzK
         hxrjniNJPbOpNZg+InwqyeUIv12s8c4v2T0DLGRdkfvyzxnsbMuRQ7a4FwZSkIo71hxX
         bhHi6sW5ry+3GZrz7g1h9J9eNkLWJOaJqJlbeyKrpHW5nWJ2xM/CVJnO7oCfIPJWtOgF
         b9LusH5zb2rnXhzhS1FjxBE0WYkuoVj9AtuJsDqbgF7C2u8kvHJrHh7/rV91AugnwkDS
         fvbdDdhUS7gPZBIXp0oVjPFgy7drZwI7oGwmPWxry7k0rr1wtk3NUmCOdn9T1AQHWTYy
         oLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180933; x=1793785733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=wLgGu7wXKb10VOZsizT8JShPSfUEOuI2beD0/bhSkDxyG5IcQ3S/4dnjrmKp+4+W5/
         qrCfr2Udz867bW2uvilL8kptwciURJCbTvdRwfHfmKqmR8RGTrnfT7X5TGBWgUr1NQMQ
         bvmBBYKwHdLyuwd4H6RkU48dUJTXolUeIZjBRHC3QqsPfu1jcE1LnGMg9AoOTJyH3xnA
         h1cqwy06NrO3DzqDGmAMh2o0Ly5d8hClw0Bfrna3MWmvO9pojP08Bwm0aUPeleTmbP6g
         sYjLsHtTxPo2x6JsPECL53dp4TMnoe+ZwdD2nShrguu1l863n26pVCVyupXb1nCZ2fTM
         5FQw==
X-Forwarded-Encrypted: i=1; AKwUvBzNssH0xDQycQnmLPxx7F05IBCrWT99fp3D+H1nKCZ59NfLCM5U66QZvWaO7v/8S+WmfwgTB16ryZNiHH0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVwfnAvgSETK7I2X8eAOaup3/rEaWbSvxGQs7DEsz8PiDUkL0D
	ioqSZQNxNKbFfhOWg8Xe9zAg8xIP7I2Y6AFKyIq/TBe6AL7Sk/R5wh93ijBEh/TFuO6iD1/Tx/J
	AmJUXBVnLAqDEQnFS7JD7gojCUraF/+I=
X-Gm-Gg: AYBFou0ju1lo/f45dJYvQI3x0oApBRvv5jR43Ki9w6WnUGfISslt71uYvIUEjed5HqX
	HWdN71Js59j5hPdtuR/X7fM37nGCu5+QXihoEseBci1+fzgT6Dm6NB4FzQnOhlk0gCwPVFfUKym
	q3QwZ6VddKiwuD8hclFSEKCeiv73xhuj4WpT5MhIY9sNZuZ7sALp39n44olhTB7qOnHFEMS6tUt
	HCg5Wpw2QUz0IT0S8Ph0fXY8bl7xPdgRlSCzUTnWKVdBB8ApV8dAbyz8EWmWe/JmyB5hGXs0xfl
	G333e7v9U1i9oIT4Lke/6OoV/PIrUEBbNnqjSgbtarmBisIAqzJryS9Bv3xfIMbKU0qKaeEW8Gd
	NYZTlK4XS+9T4P/WidQY6AfJkONgWNhL4921msbe59L52PiiO2j9/cBbj2v8QxXN38HKQS3tzGl
	L7isqXGONGbttOv78tiX9FqdLiSeWTGH5RhjG0KUVrx7w4GSONf4g9aBs1HiDt11IRyTKbrL0LJ
	RkmUTfBUNRABnRGMM5Xiyvxww==
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr156034066b.17.1793180933042; Wed, 28 Oct 2026
 02:48:53 -0700 (PDT)
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
References: <cover.1793027261.git.d@ilvokhin.com> <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
In-Reply-To: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:48:16 +0200
X-Gm-Features: AclHuK9bqVSr5ebQZT2ja4gGk1wmv0GUJ0T7y7aJfJNVsg1OI_1bv2lVUKDS3Hk
Message-ID: <CAHp75VfJ-L5ELAttN+Fz_Co2E1KHumwLZAEMXFMhRubzgVLqug@mail.gmail.com>
Subject: Re: [PATCH 02/10] string: Switch to __nonnull_args() macro
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

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

