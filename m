Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A3606A31D
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgIsa3dJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF2dj3Q9nz2yDr;
	Wed, 28 Oct 2026 20:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793180985;
	cv=pass; b=oi9Osp1ckGQvLd7D6yuSywPQAFjIcC5NGDmvlFq4wUjDEebIFcjNAjIWQAZygXiYCxw4tq9ZZb2XypsT6zAFE3Wt3iK5tpFLKZ9sFhJb9lUv5ryRyfgl7WvNMLsLkUNosAqBFQAb8ESK7gXBl+fGMTeeNXdAvrxg0yGrI0m07gx3hZHPv3CGnWSvOJzvlOXve3EV2unDJv9JcUGBB2U1dXIY88peoM/GovQndbr9FEGC8eAGJftraVwQ17LrO2IYErvTPTdZWqeSc3qPbADxA4k0AFwZTK/1z2PwbTQZgHSQiTZs9o/FWEeXIPFj4lkNcxf/CegFQiCp1GEviJm3mA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793180985; c=relaxed/relaxed;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWGwf36yiHi61w8m/Gv960bSKFS1EX6g1MOMC61fYZTtafY/FoUVKRQYMwQpfdH5XLFz1mJ+q8puxpCLHNxB01RMerhEN5N+YfBx0VBaX0pv4cPPx/GeHlTpXsaTaHPCnvPlC7J3x64OjMPLqPPINgE/ze2gFEkGUSqhx35A945299iK+Q4yoGWt7Wp5ialeo5xWDJ13NzFVEXDpxjWbbynNpuM1RmrTFVwpJC3dnjrtV4ZTI2AEkKBRHFiwCfY53Vy64k3W+D7kbXJT+Z14C4S2+WE3ZyZ8N+AgC2gmzweiX8mZnY/ksERvBy3EibK/gHeOGE56hszNkj7c05VVtA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgIsa3dJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgIsa3dJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF2dh3Sxdz2xlj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 20:49:44 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c414e5d282eso95504366b.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 02:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180981; cv=none;
        d=google.com; s=arc-20260327;
        b=RJ4bPraRk4Rbsijxmt92bV0cXtHe7+9Aq3BmMQdcbapdkwnrdJPd8psMEgMlnSvI1o
         rnINDxhmB8BNe2vTMxiXUnaBzEBd9d88m+Bia0AO+aGRc4Aup3u2l3zOFjwPAdvroEaW
         3nenCzPR3m7ow1wIa5/CTJom8fd28ewDkTmlH/vxlIJXLsM3xe1ZdBydu6qzkvoWLI7n
         YJ0R1fxcCHoc12z+INYGfyGmz++uIAdv1a8NCNGUOIlRpsDDJTzNX/0LchZq3lkwXO5z
         XNrGBc/c9S0ma5vfXhXlNVuZ2u/CvwkgnyqI+L8aw/+4uZLneyGMANAFeQHhAIrSAGi1
         r+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=mQX1hay92SVPop1OxmFdQr1Xh6U3DyxOgwzhhSn7q74=;
        b=DON1splDQDd7pyIRBYVhp6dT9yPLbuwDyIw2oshBbd1/l7Xo1u84rnDn9nTTY9HxZ4
         oqiqFHVzhKOmps2Y754z7AeYEnHGOmQgqACUJfRu0SQZ3WEcMJOJzVfZcDkqTEdUifYo
         Ps7WWkSgqFbhn82kVsft6g/ThNyZkOJFzVE4IFdo3ulh9InnwSvL/yXFEoytTqk+GWyi
         mmiKUASRKJn9yhzv2w1Ekw4NPvzMCyuSGbpfw8ZqY746lMhVSm1W7svFYScjgZnyfyla
         y79ma9q6Mb46CKjY4/b/2bsVY3U1cPEwO2l/L28sFcoGf7j0ssK4AhwwHwUDvctvTJuq
         iCSw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180981; x=1793785781; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=CgIsa3dJXSox9BHw4q2efefJ9VLSeIjuZtoiTIZvGQn4pQL4H1KNHoFnze4oWiCA3K
         Puyc5WeJo0uxbOB5Pw5gvCyNNWlJSes2LQejsTXVBvOLOi8oW86fi28/rFIIS8pZ/PB0
         FLXFcOUR0UK6Y1ok1PAEn1kZnQ7767PM/MM6szqHJmQu/QzwegCeidfwB1zLMHS8HNZp
         iWivlXFrOLdcSjXpzEY+aUgOYwmJPN9lb1ERV6pvNg6+04+nvnkWoCDGQHFpvh/l0yk4
         oOihUbDlAd8gpau+kUv8O4/SYaMzFtX2bYBThVgzoDlSoForWMWoVWGe6TapV8d793kc
         A8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180981; x=1793785781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=mPUN7/RHagZ69lsLfkhROdGIfYL8QuqqAVcEFvm76/FrjFmHjsIYqOzdWmE9WFWKEP
         u1u8o/rXFhvk3uYzoHFG8Wok5q07qCE5c4Vl7V4oIiwHffLzzSdSQ0NH+GxD/mO2YO2H
         80UVl42WX+1niPLzTFY6flyehAt0b15O0wkfgtEl1cmLD19dw7n0gCgMkJTvKxMCh6jS
         e1dVSlipA+ibELWNWdVsbcJ4Jl0LRvxu9wkWYNjKsh7+cIAkUHdhpxo1G9jJqW9rVwyg
         GzkOn6xMLGm3cVGdWq3CaaW6FgscrOVUOlqo9wDX1YwXKRvaSqX7Wxz+VHPT84QlhW9I
         WqlA==
X-Forwarded-Encrypted: i=1; AKwUvBytLTheFdUi+1nIi+QRGBPWLKGIBnOg2UOa6MQoKjHWNCcsVf3E8CvZY2UwHJrj7vecrBbfpc78e27cE4o=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK0Mg+GFKK36ppT86cwPRJqsa/hPbkAbCU2vWSh+T0om/TIQ06l
	zEDo3ycGlgSojg32eSNRWaT/CSBN3wf+NrCxuoYgkb0SkDsvyyUtbt2u7wSeo6AHMfuEadMZr2h
	DDvb21zNRwIqLpRMM3A03JpZJJYmYzEs=
X-Gm-Gg: AYBFou3jFvvjoWX+4cNaxLUPKuAjSUjeQG9vdexh7mH3L4Sw4yvOsHDROhAzaBh8LV0
	ofJBCC8cKoxF1kcw+7wfr+OYS2h6WPxAmfHByye1JzZlyfDZMuO6xhVVg6nMyrzbV7la3+YPCPu
	p4zNZownmnUmKG3xa5iWFHegKXZUiQryYR5IfcgFdBvo67ONHSvQsmpwuq3IdK59eHcNzrPAjBk
	8HzYfPr1cS+Gvwj3nySRLcpoaprZc+MARlv1ypbzShYm6uP+DYt1yg89eovLi/tCdbvWM4+5W5+
	fW+8rKZm3rsUpZxNWwPd1H9EL7p6m001SdUN9NERtM/74RnmYAhpvu1wftqlI7xvwbJoZTZ9M2c
	n+UpT5oRN4ERdWRN30Z737BiYQ70VfmE+BJMTmty3fMsC4S+HE6l+ofa2FJPib3bR8CqapJ/zJY
	Oa1LEohptJYP5hQVGU4izUOALvO8/l4YBBcTiwlO8TWaVk4RNZl25Ti3rOg9pswm+FlVw9ma+gg
	dsnQkaULMBcSbhs7lLYFPLPczE=
X-Received: by 2002:a17:907:d48d:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c49bdf7de97mr167322666b.29.1793180980909; Wed, 28 Oct 2026
 02:49:40 -0700 (PDT)
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
References: <cover.1793027261.git.d@ilvokhin.com> <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:04 +0200
X-Gm-Features: AclHuK-kwXGKz5n7QFXQ4iO49tQbUX582-rj9xJLuSYR3NDY9XFvg2hsu7UGHjc
Message-ID: <CAHp75Ve71BfcWr++PfQPiOc=OURNn1-cdJey=M1xBVCb0HhHQw@mail.gmail.com>
Subject: Re: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
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
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

