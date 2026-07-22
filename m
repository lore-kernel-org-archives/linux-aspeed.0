Return-Path: <linux-aspeed+bounces-4522-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BFC4451C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4lr42Hy8z2ydn;
	Wed, 22 Jul 2026 17:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784704484;
	cv=none; b=P1lVXWXOqd6s6JEH/YxpdOswGFeeSNUYCZ9seL/OD3U6LkPHuf0oRgLxX265756wVdAYv9RbD+qg1dzJLC0lGRmkyh2ZiprefNR4TOQdU/H0rzmdYk3pnL5u0fIIgI+nglg3MkJIwYaT8MEIOCia19406RKZDyNz9xqVh0uw+UfPsXCThH6LjGSJjmqZY7cwlXbdOpbWT/HPEetii3k4gSrmxy+Sdxl2/5b0deyUa3muvoIevrxzlhDbFkvjdpO797SXeAplUIx6ytHvLGlzsZs0/oREC2uMDIB3+cqQRxNx65lal37jlVzRkaFZKAH7lK7U8KOlMurjS9fvLMOdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784704484; c=relaxed/relaxed;
	bh=ewtaf/n/usdJ+GRJDxLAOz4V63fe/JKprJj8bOO8Fow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6SKJ3KvfxG1hYpu5jeZtd48/CRMxI3WpVt802UGKPlC6ZhaOR4EKtaErpKpk5e4EOXSxq5W5axLGgc85+h355SVUwFOqbJamFvexH9iz4UyIpwRT8kAaQ1oBLwJmZaoglwm8IIrskCk9En25UPvNnDi4E+dKDeJ9hkvP6nPINeW2pWypWrYmInhtYkrqwOLQo2bv9qib4g8jpK+1Qnsht/29FlTmMKXBka1W7VoiNI8Y87VbYAImXTNEn+ZfA1LyTDq6BJ4zUwRrfFGYFGxWnd3ZEZenSbZkzo1gV9kMJF0Ugqn5cIE111P2WaPf3YqzTkj5/Bw4SdltuoyDWAOMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RvkCfaYV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RvkCfaYV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4lr358ghz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:14:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784704483;
	bh=ewtaf/n/usdJ+GRJDxLAOz4V63fe/JKprJj8bOO8Fow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RvkCfaYViCH3L6gzmFbVpfXLjgDELs2eDRVHsSpSfXKUF47+Zv+8CFOuZrRoy0bC2
	 ojr/OGWJvRfMwzsFy/d14vWmJLDclEtnhMvRH0y+9QlZzhNsicmHBNCbXlb6avBhgo
	 ufrdcraDoB3zolpnXWIrLalF9ddivcoEUnTXshF8gNA/ibMA83z4oJsQsK/y6/JgoL
	 0fiEhg6FWWyVaiM9AT9ezNmTzsPpLuLAMqBfCBjoqz+mljfbkuVnZcFR4P5gIR4LVd
	 PG3IxwqRcqgrrKeXMtDos1+cKpfy/PCUie8ZXDdVfrKcpT1eyS5trl/iXQnvlH5Aal
	 KkN1a8eIrYZnQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ABE2E65B37;
	Wed, 22 Jul 2026 15:14:42 +0800 (AWST)
Message-ID: <27318e19dee124898b95a10f9cad28f456835da4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] ARM: dts: aspeed: bletchley: Add second source
 devices
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cosmo Chou <chou.cosmo@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Date: Wed, 22 Jul 2026 16:44:41 +0930
In-Reply-To: <20260714120816.1504058-1-chou.cosmo@gmail.com>
References: <20260714120816.1504058-1-chou.cosmo@gmail.com>
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

Hi Cosmo,

On Tue, 2026-07-14 at 20:08 +0800, Cosmo Chou wrote:
> Add second source RTC (ISL1208) and LED controllers (PCA9532) for the
> Bletchley platform.
>=20
> Cosmo Chou (2):
> =C2=A0 ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
> =C2=A0 ARM: dts: aspeed: bletchley: Add second source PCA9532 LED control=
lers
>=20
> =C2=A0.../aspeed/aspeed-bmc-facebook-bletchley.dts=C2=A0 | 294 ++++++++++=
++++++++
> =C2=A01 file changed, 294 insertions(+)

A quick inspection of both patches suggests the nodes aren't ordered by
ascending address. Can you please style-check your work?

We now have scripts/dtc/dt-check-style. I would appreciate further
patches for bletchley cleaning up the rest of the issues it identifies
in strict mode.

Andrew

