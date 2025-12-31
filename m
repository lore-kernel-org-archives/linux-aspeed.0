Return-Path: <linux-aspeed+bounces-3245-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E065FC6166
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:22:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djjTq4phfz2xl0;
	Sat, 03 Jan 2026 12:22:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767217106;
	cv=none; b=a82WqJLx+UUscUC1G7pWQOXUlzYyxwrUAwTWYLtInNnlvwolD9yHl87FxBVwvtzIjDGlTBM37abKkXLVs5WQuh+/s5Cn0bGdYP5+2LCHYAnBfLbNMz6tuFijVThFsifMHg27S9NIVDKnhuE5DcmjuieU2w4xGALjyi4AdUcjFzc8SksWZBgHxLNFhg8RB2qP/n23ypHo5Ce/RwMnn32klmt9jPdQB2EMbNLcy4ZT8WSNHXU7DU/J0vNqGmWSQm21yUSKiPyRWhKOAiA3sAdc21RdChFQYQkJAXDrUQ3SMMoSTTemloZj5/+b7zOOG7QYACP7K4af+3gVPKSX+d5CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767217106; c=relaxed/relaxed;
	bh=bNI4moxHzlL6mKNWIZsVYWKbjwRce0cuGLHEF0rQIaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Au1p5nboWvxQy2McIzgl0wqcZT8xVxQgyVvk0BDS2m0DvK3FzuB+rEOtEk7FHSI61F/5WO3NFhE+ldApDibJwym62ZQilWT0tcMdd3xxwX8+Pfcl//vcm38HxCUJx1ZxAXvzv+EBXkq0OnTovatVV4WO5u8uAx3JdeiO6jwA5xKFozHubTzfiRo+DlVX/IK/IIu6SyjJEkAk/7Fvt3eX63MS8SzDZI35JBiEsZr3ep9cN0vgdEcZwpPzRe7FYni6cVKCxXx3yvbN8mFea24LHse2wGlkObFTGo2cHLARK90vENF+DzYcLP/O70a9mCccW++WoNz5Dw1uGEd3a0fY6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ud1JCDQ6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ud1JCDQ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhNcK6Sb8z2x99
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 08:38:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 50B9F44216
	for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 21:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31844C4AF0B
	for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767217104;
	bh=bNI4moxHzlL6mKNWIZsVYWKbjwRce0cuGLHEF0rQIaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ud1JCDQ6O191m3kYD44vkt1ShFs9vgo4JobjnhWd+evWDfkmkNYuJI5wcSNL4tWrL
	 0Z7WpJ+bn7kwco/mfx1YQUb+Cf2JEoE/aLmZRvF04wFMC+yaiiiu1Wrne8U3CLXW7m
	 rlf4vA2wklUadaJzq65C3YgpX5x29MdV+ltwo/Vd2zN8HofhUcqV8WbtJ0uksC688J
	 ++6tS4KWFBNxOPHIOXyel+T5t0WvUdmHTbHNbqpkG920NCyjtE7n4FDHgl2Y4TBj64
	 W6M7ykqRfovFexXy0AhEWH8mXR/2CkOb0cvGL234hY0g3gpG0VTXQnHhEZE4eY7Nqc
	 84vzL6TQKrNEA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78a712cfbc0so101524397b3.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 13:38:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc8BA6QkgaeZEh2NMqKYfEATg51xglZBisN1uJ/NeEXrPxpQ2Ad0HHOimdsYfVij5zEsjxT7ONxWgcVyY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxcVTThyF/peihzsJLnFr20uMoLmeboePALHzdzSkFoElKaAM/2
	O8cjBOjT8YZ5hbzKt7ZcAv6cUD4GamzR6Em6UbNIKMu+44b+lVXziNNCA1orX2xJ6N7vfF0E3Hp
	Iz8HkmC39M+MBGshJyeDo6BbRpnoJ9Aw=
X-Google-Smtp-Source: AGHT+IHGZ+h0d0MHZDCxvMCHygNM5e2LD8BSbr6KIbsOXsE3Z3p+Mpa0Okg+bD8neauLjOFoWJ8WBhGUbfiIcHde2OA=
X-Received: by 2002:a05:690c:90:b0:78f:a9e9:f784 with SMTP id
 00721157ae682-78fb3f5d4f4mr320728627b3.31.1767217103495; Wed, 31 Dec 2025
 13:38:23 -0800 (PST)
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-3-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-3-21b18b9ada77@codeconstruct.com.au>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 31 Dec 2025 22:38:12 +0100
X-Gmail-Original-Message-ID: <CAD++jL=TXQyGD5nSdg37KK=OrUJDwi=2pXQciLr+udC9hjCVkw@mail.gmail.com>
X-Gm-Features: AQt7F2oBzR1qfgGQMAe5k9Xw2nDJvErMxOKzOVsHNn8uiB-Wg9Ho6D3OL063WYs
Message-ID: <CAD++jL=TXQyGD5nSdg37KK=OrUJDwi=2pXQciLr+udC9hjCVkw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/16] pinctrl: aspeed: g5: Allow use of LPC node
 instead of LPC host controller
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:

> There's currently a wart where the Aspeed LPC host controller has no
> binding specified, but the pinctrl binding depends on referencing its
> node.
>
> Allow specification of a phandle to the parent LPC controller instead.
> Fall back to testing for a compatible parent node if the provided
> phandle doesn't directly resolve to the LPC controller node.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Reviewed-by: Linus Walleij <linusw@kernel.org>

I guess when this is non-RFC I will just apply these two patches.

Yours,
Linus Walleij

