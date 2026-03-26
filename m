Return-Path: <linux-aspeed+bounces-3775-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67291109E550
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 05:35:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhCCh03zQz2xlM;
	Thu, 26 Mar 2026 16:35:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774503311;
	cv=none; b=Nh7KVIQALz6ijRbQXg06xmuDYzGdtwWZyUklH/Y2JXWEY0Sdkkfc8Uz9h+PTyJQWGkMKHU++beUExGw59GPPw1+qRGTQWby+ElY9CnCabhFv85UgA1DkfS0es/ZNNL7IKiz3LnpE/Rn/SmfwAC/JDp6PdXrN0WfzZuatoFYTw/qhbtRAFDUtQTnL8DUtMVQ2DZJG57mIZCSmrpCdOw/ngH5oAHWyNUcSKzD/EzomVCDuP2yvgCK85XJ95N2K2tJk5zVy6qITiMLnnj5IqJ4V1HFyCWQxNEa8Nun0oVupQJ8EXuU+FErUTNlXieK/ltzdEHs8mZYisRXVPijfVzyz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774503311; c=relaxed/relaxed;
	bh=il3g8uMgmZyxfuqxE59MMwiS51z8GXa/F/F4aoMlsVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7pgUGh+gzvTJyR5XxAgoVVKK9U+rVIWzLwGEA5lrjO40zsZb1qHI+46Lq/AJ+emUKpUZOSb9uuL9SDO+t+iOdnk4GNdF7tObBubyx5NPqfVgNATin6wlMTNrzT581a1zFrj3RaX/+GWwfLqzgxOm1F0vUUNrWze51CLNRUnlw7gUW4FuWwhHtWvF0Dq1HaYrcD21okyoQSemwnh2morEUR/bVTALGnBrCnJFubij8tiQtsmtYA8NbrFDTpGizy2I/yLHZjSQwNPgt5kcX+JvGRh2hCxh8RFUJFFvlUYsFujI6pe6gn3xU0Wg+p9gUnU8CWjbM4Q6qcho+YZJRDMpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VTgnUmto; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VTgnUmto;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhCCg0bfvz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 16:35:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774503310;
	bh=il3g8uMgmZyxfuqxE59MMwiS51z8GXa/F/F4aoMlsVI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VTgnUmtoXWYE/vqR1G5jvE2cATbzQoH4Hd2dA7qzwHED0B/nhEVKPMpync81pfwRD
	 YGVzk7eBFgXMKfxap7NLscIG3TqecNGwQT2lPFb3oANLMo5vvooG0/qtkMEfggLU9Q
	 ObR7/76IWqPu8RLy11UNVj6lNpKi60h0AoA036fP98yvsw4SejcHUkngf46h0z7xM7
	 hjJhNMJI7kQU/AmLVhhaR8j3UHxBfYqjkZ1Oe3LaU5LDcs56w/w3R0bGoGdWu2fM+X
	 5gpPBUmv3t4BlxNNCqtzJGLZEgj3NXHuW64Ya+KxthZ8cRsP7jydqXMPwBmzrByRV4
	 O0b98Y6M9glCQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 81DEC6597C;
	Thu, 26 Mar 2026 13:35:09 +0800 (AWST)
Message-ID: <ec13c056cf74b4c7741e6f14cf9c49c159066f36.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite5: Add MP5998 power monitor
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Daniel Hsu <d486250@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Daniel Hsu
	 <Daniel-Hsu@quantatw.com>
Date: Thu, 26 Mar 2026 16:05:09 +1030
In-Reply-To: <20260305084650.24511-1-Daniel-Hsu@quantatw.com>
References: <20260305084650.24511-1-Daniel-Hsu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Daniel,

On Thu, 2026-03-05 at 16:46 +0800, Daniel Hsu wrote:
> Add the MP5998 power monitor device on I2C bus with address 0x46
> for the Yosemite5 platform.

I would rather you describe the purpose of the power monitoring. Why is
this instance of an MP5998 necessary in the system design? The address
of the sensor is evident from the details in the patch and isn't
necessary to describe here.

>=20
> This allows the hwmon driver to probe the device and expose the
> power monitoring telemetry to userspace.

I would prefer you reword or remove this sentence. The purpose of the
devicetree is to describe the hardware. What the firmware/kernel
chooses to do with that information is a separate problem.

Andrew

>=20
> Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 5 ++++=
+
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite5.dts
> index 2486981f3d6b..6287f80d70d9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -422,6 +422,11 @@ power-sensor@45 {
> =C2=A0		shunt-resistor =3D <1000>;
> =C2=A0	};
> =C2=A0
> +	power-monitor@46 {
> +		compatible =3D "mps,mp5998";
> +		reg =3D <0x46>;
> +	};
> +
> =C2=A0	power-monitor@47 {
> =C2=A0		compatible =3D "ti,tps25990";
> =C2=A0		reg =3D <0x47>;

