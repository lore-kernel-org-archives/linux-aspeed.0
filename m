Return-Path: <linux-aspeed+bounces-3136-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080D2D65C6C
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 15:37:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWdGd3X90z2yvL;
	Thu, 18 Dec 2025 02:37:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765985865;
	cv=none; b=K8z3DXod6HGcHOe4XRFoXiWIOtoUAyYAYNgyeG3I9VqA1Ny4dObonnZ7cyJoLrJ7BadbYLhyI3GHkQZz0N5l0vw45ysUvctpt3bzqXE+RjBPYoyKNADmKKgTj6e7zgxI4h8raKxfWTa3gcyME5WuzghBGLsDAhmIo1bK3wqCcA1hteQ7+4cGVZYHvMeWFQXW2CmIwtwSw7DOBMXRL133OZY/pvi9xBW3RkCUrFrpgDwusW0G3Y2ViCqF5zKLN2eijdN+FhQHVP0iZZ0yFGwruGUs5W/13YaEKEYc7TVqKp5PAnrk+yur42J6k7sNrvHoANPJ1XFY5n2s4rCPjAvqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765985865; c=relaxed/relaxed;
	bh=P4Hj6kUIjPKS1U4b5WrIC6hTm+90YDETyj8ZGZZXRGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQQlfzIxrAKVP2G2k/0dTeTETfEN1lHN6nwVSOuGJJ9Zg8UMwfdBXGl8HporyO4kZBA2mIn4DbrDZVSfw8CgFmRgU2lDFOpGZ7rgyGMc/kv+4GaNoDXX2pyFb/nW8fdo/cToOpDujBxOupPbuEcqoJ4JAu5ifE3sK73dgUOMr+q/sGEprpfjh54YOUcgtYJWKvJiJ0kTg0WtYPqcH7dT4971BP3zxBfsIAxCyYYX1YcHe5nSUVtcR9ZJ9B8V7/eRFUagJwbWHXurG/qrVt66Xvg0yd9lx6XzYUvIsSb0H7RH2JKMoBRoCxGZ2jELnl3pPih/dZk1xcT/vBFxrRTGOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hMNPbQfH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hMNPbQfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWdGc39Kdz2yvK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Dec 2025 02:37:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0275F44186
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 15:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF72AC2BCAF
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765985861;
	bh=3zWGgAak/FBm7Vkk94ZrLytELeHbedaeePRas4C5o5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hMNPbQfHkiOGVqJHw5AtuOCvRV0FWKVO23ESw20F2cpxcqWTBIOhlBqGNkwequi0i
	 3oeUmzcEgHgSCtPoeLi5W9KvVXmE1VGX7UUnHrN1mtR68GvWl08uXF7HTsH54i7ZE9
	 KfYRP9/8MnbbeqwSYkqRzywXs1Oee8xupqaf+a3s5LDAgTLnveEoDXptQ80gqAbzq5
	 bjMNZezJ7p4GnTY2AwYJ0eq5AHSinGdYScOtbFN/Adxv8qepgBFrnvzwv9d+LJGjra
	 iG70B1IeKSjTYdQQgNkT1NrvCLmUQmuqa9VxS8bv5ivZq+pOTD21TTRtZYR98YCKkC
	 GNKlOB4AN3+tA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso491671766b.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 07:37:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNGmHPjnR2YH3eN7MhzePdloLTQew/FAr/F7a2OQOgrd0nHekpHxuKJ/Ke2f5To1QVDvDViQ5A2mvyjyg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyP7qMT9fKD+7t/hivbN3Uht5GgXFrntcEk7JNhirAY+RBFNYfd
	Ca1EGUTRTO+FQaXeg6EBTYoUR8Idg9ipRqKNPUiLxjdBeA/jdzfA98YZ0EbxFcgDNNLOaKUZMRs
	yTsUryZrxHClLZYiqbsfeYC5mQ0ZvfQ==
X-Google-Smtp-Source: AGHT+IE+MbpVy0D9cI7vtayEcuAQ5BpKDVDav3dQlj552I/4svzEpwf9VDtWU/NeRoVokGuFNkCPT8ATPD0NU91eNy8=
X-Received: by 2002:a17:907:3cca:b0:b72:c261:3ad2 with SMTP id
 a640c23a62f3a-b7d23af00e6mr1859042566b.50.1765985860268; Wed, 17 Dec 2025
 07:37:40 -0800 (PST)
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
 <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 17 Dec 2025 09:37:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUaKKsJ8BCNbVXe4vLVsQ2Av7VuWqf9DnUKHeLzLb8NQ@mail.gmail.com>
X-Gm-Features: AQt7F2q-nb9Xy6ZmXCdkQqrO-_0mpnqJ_RWJ9ZzKv3sOBl98lQ-TH7L8rvtaBLo
Message-ID: <CAL_JsqJUaKKsJ8BCNbVXe4vLVsQ2Av7VuWqf9DnUKHeLzLb8NQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/16] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho
 to DT schema
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> From: "Rob Herring (Arm)" <robh@kernel.org>
>
> Convert the ASpeed fan controller binding to DT schema format.
>
> The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> rather 1.

Okay, I can't figure out why I thought '#cooling-cells' needed to be 1
here. I don't see that anywhere in the tree. The driver for sure only
supports 2, so anything that's not is an error in any case.

> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml   | 106 +++++++++++++++=
++++++
>  .../devicetree/bindings/hwmon/aspeed-pwm-tacho.txt |  73 --------------
>  2 files changed, 106 insertions(+), 73 deletions(-)

