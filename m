Return-Path: <linux-aspeed+bounces-350-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BDE77197
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 00:47:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTlv4L27z2xbS;
	Wed,  8 Jan 2025 11:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736297259;
	cv=none; b=koB6ixFV9mdSZhUlGdif36aaPg8jOEqwBO1zTrructOMUW56GAs5qzxWJayaFrkU8FjsRoAK7kQaepALPNyZ9d+v75pTT1+RpCxlCbxYr4wpazRZ3qw+aAUuRc9Co791Ie45b6SkyUAvhd0ku+7L6fqNur0ueWbXO/7iZDdfU9HpaDnRTtcz/hpid4S1KVbKu/r6Et1nicrNOEDqIpPKBsFIMQRo0QKuZJI/ZqkX3Yxu3lpDDoe5sL+Cuiqz1CfMwvrgPUWjgYiKKH4lSxEKTCxuVQyCvEAgVIA59zqw0qN1Q+64IY67I9KExjEbbB0HRsaKLHdPmh019zwiekS/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736297259; c=relaxed/relaxed;
	bh=0IuofUalrcy7DmrnwjI1oNb1zpstHlRi3sWa4Pj967M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6M4t5KfXcFYKiSIFnTA4452VTMdT85dWQ1wU+H+i272ogvhzF9dWlr01UjnbNWZr2u3h57XD/c58ZGh+kmKW8KOO3xd2AmDmN/RXALDn5TCF8otztmbCyMgas3kD2/bqdUf5EOhyGvscEnEvjmPJ8X3FOpR63u/FFXRZm9hXAhW/tG7wfjNfkSDgVtF8x4yaIVjf+E5PBDyCwnCkpuI3oGMh8Zwj7PzO5jcODSVeHJnRoFbkoCAhHBc1RM9i7fwVYVRVB82HKGMypwWVhLEBcIkemvOM0gWFZ1KaMxg+Zoe+HD+ii/qeg+RM4w3k9xv92afIlTqvoM0ub8RLCOiVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hI7UZIz6; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hI7UZIz6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTlt6CgXz2xH9
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 11:47:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736297258;
	bh=0IuofUalrcy7DmrnwjI1oNb1zpstHlRi3sWa4Pj967M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hI7UZIz6k5JCRm4/XEc1M7tAqD0h06F+76ojQyZf13GXD5UAfzt7ZL5idIoSGMMnD
	 YMHibd8WZQDGdBy9+vYajCVCUx7+mO9ZdWG2QLbkBk/EOH2zEt6W3y7cK5jFGjNkwb
	 bsRdd0tp3ZOf5+4jdu6Gx8ewCGm+qfV2hDhf8JuBI93rBmMq7GV/GQ/8rmWpwRD/eQ
	 5PO1wUzuoDqbSFir8BpuZ9H/e6yg/MgieQy6t1PpdN4flhtwge0+xFfCylTSpObOXy
	 y57X4hgAUXa4An1bR09vJPT2oI8cr/nxSWyH4v0b7TCY4DEdTQtU/BYuxJ6xoqlvcD
	 1TSi9U9Acd2wA==
Received: from [192.168.68.112] (ppp118-210-64-24.adl-adc-lon-bras32.tpg.internode.on.net [118.210.64.24])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 65E0870801;
	Wed,  8 Jan 2025 08:47:37 +0800 (AWST)
Message-ID: <59b47269065db207c2f0f8268d958b3f647fe05b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: catalina: update catalina dts file
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
Date: Wed, 08 Jan 2025 11:17:36 +1030
In-Reply-To: <20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com>
References: 
	<20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

Hi Potin,

On Fri, 2025-01-03 at 09:42 +0800, Potin Lai wrote:
> Update device nodes list below for driver binding.

The devicetree describes the hardware. I prefer we keep references to
drivers out of the commit message here.

>=20
> - Add IOB NIC thermal nodes (TMP421)
> =C2=A0 - 24-001f, 26-001f, 36-001f, 38-001f
> - Add FIO Remote thermal node (TMP75)
> =C2=A0 - 23-001f
> - Add Power sensor node (MP5990)
> =C2=A0 - 16-0022
> - Add main source fan controllers (MAX31790)
> =C2=A0 - 18-0021, 18-0027
> - Add 2nd source fan controllers (NCT7363)
> =C2=A0 - 18-0001, 18-0002
> - Add 2nd source HSC nodes (XDP710)
> =C2=A0 - 20-0013, 20-001c
> - Remove all ina238 nodes, move to userspace
> =C2=A0 - 16-0041, 16-0042, 16-0044, 17-0041, 17-0043

This seems to reflect the patch itself, which isn't terribly helpful.
The commit message should explain _why_ you're making the changes.

Can you please rework it?

Andrew


