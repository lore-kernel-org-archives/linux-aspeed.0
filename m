Return-Path: <linux-aspeed+bounces-4528-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD03C44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 11:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4ssZ5k05z2xLm;
	Wed, 22 Jul 2026 21:46:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784720786;
	cv=none; b=NX0K7emNSfC9Q53ZXqhKjiz6xK7GvPqZehk6IpNl+p6yw3wofby7U/fu88ZeirVhgJa0YAEu10UkdqWWtKekRySpWs7M7hMKYTUfsPt4uwL5hXdHBSEX4B0pQzm8tGZIM1H+aov6v6P2ajzLLtxXl1TggvYWCfx/meRwMD8Q32MCN0csc7+YNe7sKG3T2WqfVMIOdll15gQZxlNOaXwoF26IYXMS1ypnSjblFFuoDvNJWHi24CywZwi0VmYPKJHGyDYNsp9L7UN+7cfSkH9nJ9AbgwmTYZ7FxjC49AiVP5ZbGzx/RO/HcQALFRZjBiOSgVvgZ9UCkpUFn/yjf/CQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784720786; c=relaxed/relaxed;
	bh=nGvE3+M4u43M1SZQpAfJA3EfRI6JozazVv+5YhQ9wt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0PJvVntKdUXbZGBzck2zk/TRpHdDSo14DesCrh6u8bAx9v3VZ/Xpa/wceCg2SawudAz+gSRzfyNpy6ZCer973V9fGzASRawA32ntoBvW7htiCwvImPOVuZQweKpHrYuRHYkkmovb7RWoUxwTheQ7a1TM6JxMrjmOKFw9tDmx0pMAcX9rexm3ohVSs8/MObYrswKlPDFKpsYvR2tf6ehT0toxKHC9TAHYCJ98VdhI4PXTbZBnh4tRoJd/99/L2vnZq4irBg4cVdUkjG53b5rF7VGlNf7WX/SYg5hqDUBvYnmzEBuQcv3A+/TDl7VmiyOq6y9U+MQX6NxhEgF9L0z3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gOcSr6C3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gOcSr6C3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4ssZ00t0z2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 21:46:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784720785;
	bh=nGvE3+M4u43M1SZQpAfJA3EfRI6JozazVv+5YhQ9wt0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gOcSr6C3tjWVfaZA3tml4aiqNrprIE3MYqA2EGVKAd1xgO3G+530/9cspGms1beWJ
	 F9IVfyh5udQNuBsRR+TPwe2th7ay3oX3KpIlhqU19VBhTgUQWwGYpHQ9DiLJwVm/j4
	 gGwKxjklw35Xp/vw0KZ/9OF3GhUCnDhJrcx1maKji14u3wifbiOBkk5UiLm+kIoQvX
	 BKZSY3ffjkZHNsGG9+p6cEam2xQK5XpaUL262GE/+v0VdIGzGTGjot+VIX6zKLCcLi
	 +vg561piDz7O7A/UQnf09b19wer4yOabsZyTC8DwLHIFMnfavMjeQ8ecbe8jiezgD4
	 Ccv2T8G6h1hqA==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6E977662E1;
	Wed, 22 Jul 2026 19:46:24 +0800 (AWST)
Message-ID: <8a75ad0ae44f1231fd75be6a617962a4d2c58e7f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 21:16:24 +0930
In-Reply-To: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
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

Hi Kyle,

Apologies for the delay in getting to this series.

On Mon, 2026-06-15 at 10:46 +0800, Kyle Hsieh wrote:
> Summary:
> Add linux device tree entry related to Meta(Facebook) ventura2.
> specific devices connected to BMC(AST2600) SoC.
>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>=20
...
> Kyle Hsieh (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: arm: aspeed: add Meta ventura=
2 board
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: ventura2: Add Meta ventu=
ra2 BMC

The two changes don't apply cleanly against bmc/linux.git
aspeed/arm/dt. Can you please rebase them so that they do?

Andrew

