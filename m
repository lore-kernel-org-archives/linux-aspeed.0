Return-Path: <linux-aspeed+bounces-3588-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6322AEDEC01
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Mar 2026 02:41:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcP95NYHz3bt7;
	Wed, 04 Mar 2026 13:41:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592077;
	cv=none; b=I/04lowBt6PgZoT6ac15t2RQOhIohpLjJz3rV745Ww3AHnPj92x8fIR6VFuMg7O3GDPUy+XGLNI/6gD0BD7ryVGccep+2sXVfeKhMfRowDuH1bfUE+AAUZrrTTVbEQgZri17q8OhZmQt2FGnAZ6ED569z5KiEWb4KZAv70uwc1Kd3rOPZGImaxzQQIVuIvROJdRL84NpmBJdUiH221E/+bTSOFl86Tur3nAeDHg0c3FXjJp0UnXSWod0bkpYZrEN7dPMzTrIwWvWXTPtsN/whGnhmqhfM4T7F9fKUg01H3X9ICcYJ8QM5MuJFgYnWsuhRU2O1V8dRracqQVJV5+NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592077; c=relaxed/relaxed;
	bh=96lQsWqDKySGJZInYDPP1iz7MJpHJVtnNEeUPS7642k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dhwcw2NVm1Nvy0uK8VVAtyn54q345Na7KmwhmNSzIe4tge9qPVT3MbwFmDALbwxhKz6paDUugZsZc5o+O1raTGkDlLI1MC5WddlotmJH4zgNeDcFHZhIwNKjW0Q9QK/80Y4TiCVK7K1d9H24cLBgfJoGXzF0g2DtxrCNfwFx6ZPHVp+CzzFPiPbr3bJV1PAIu30+PlU6TixQvxNtRQAiaZ1CIMqva4mkofEKgvgDpJaBQqHXsXcyTn59qd6SBOOQtocvRc/o95re/xnjmkU/o16656GnlCbvgeZZ4KjYgMJNlHbj/duHONDSZ66OuF7dg2YainwbDu+C+KmOHBQbKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lHZfQy0/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lHZfQy0/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcP92B4Dz2yLH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Mar 2026 13:41:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1772592076;
	bh=96lQsWqDKySGJZInYDPP1iz7MJpHJVtnNEeUPS7642k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lHZfQy0/G6rk0rkPwPdvfIMI8Mh7+Ivf/8PBeFOKXWFLcoeCs1/pU62LFbkvL86T4
	 Kgpczg1MfdW81pTAR7H7ttfWH/VN6iYywfBC7RZebRac3dmR+RP3LlCiA41OvaunC+
	 iiSL8gjFT9D3OdB1lddQtX2+RsKE6/jshGjIngquVcWENpoOvOQjcF8reYuxAEFeiQ
	 t65g1VTuB1sRNVCsKumnK8LktMFxnYtPbMdJV/CMD45q+LwkUdUDN+TiHn5CxRsKF+
	 u9n5xXefWzjABKeMO+fN1xFgUO4esLN/h4PtY99OUkcZpaLAKaVtmRyOV52uZvA57L
	 ++s8Xtj003JuQ==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DBB16000D;
	Wed,  4 Mar 2026 10:41:16 +0800 (AWST)
Message-ID: <73ea41bf341df0e3215c58a029c9ea2386c4ef8a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/8] ARM: dts: aspeed: yosemite5: Remove ambiguous
 power monitor DTS nodes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Jackson
 Liu	 <Jackson.Liu@quantatw.com>, Daniel Hsu <Daniel-Hsu@quantatw.com>
Date: Wed, 04 Mar 2026 13:11:16 +1030
In-Reply-To: <20260223-yv5_revise_dts-v5-2-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
	 <20260223-yv5_revise_dts-v5-2-fc913e902488@gmail.com>
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

Hi Kevin,

Sorry for the patchy replies so far, but this series bothers me and
other priorities keep bumping it down the list.

On Mon, 2026-02-23 at 19:17 +0800, Kevin Tung wrote:
> Two different power monitor devices, using different drivers, reuse
> I2C addresses 0x40 and 0x45 on bus 10 across Yosemite5 board variants.
> Defining these devices statically in the DTS can lead to incorrect
> driver binding on newer boards when the wrong device is instantiated.

There are effective methods of maintaining devicetrees for variants.
Why are we choosing to remove information about the platform rather
than use existing techniques to properly describe them?

>=20
> Therefore, remove 10-0040 and 10-0045 device nodes, and let the driver
> selection is instead handled in user space by the OpenBMC Entity
> Manager based on the actual board configuration.

As a separate problem to the one above, while you may run OpenBMC on
this platform, I'd rather keep the description abstract. We can finish
the sentence at "... is instead handled in user space" and remove the
rest.

Andrew

