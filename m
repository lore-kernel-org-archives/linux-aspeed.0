Return-Path: <linux-aspeed+bounces-658-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A63C02193
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 00:02:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YngQf2qRdz30NF;
	Wed,  5 Feb 2025 11:02:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738713738;
	cv=none; b=ZoDmGhIcVu6040ILhJiFI8yrCHGe0XiATVmA9RE2TpWl7Ce2nxUvX7rWtaJZzWXnS7SGaPQgf1ei5Yf4jt9HJKpEHneQWE2dpiHuI1geNXW/GhVojU3gctGay2KiuL0td01ou/w3+GGD6SQwqGM0qlucesy3vE21/7RyIwiQzPR32p1DQHfIMCTsyr+vJMd1r+swJgJ2oqmWfeKvjZVM4B0WSx7+g6zCc5SG6MijKEkBQE0Fb7IlUbQtqy3n9F2FCrEfz+pNoxhVneXxXUP5xYFDGXCZAw3QE6xmSg9dS6KwhdYPlqhCUW1Mbq63G/pkdF3k6yhC/S6V4tB+P2P6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738713738; c=relaxed/relaxed;
	bh=n9dR3JEhqnb9OApW3VcHCh5n2riOWy7LJANruYsyTtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaALy8O+IrlXgW6OzuXzTRmgiBxdgo44tJZTeYRgnwAboCKLLOHoCJPhO/YhHa9sNEpzUT03LPWkLszhRQMN+aKhsFzIei1oAc8v3mh5/WCXIZQuoc3kNmEI7mH+I4+7wr/fPbR46iGe9Qq6kQYnZgxYoZEh7PiC7qOSAOb+x6Q0lVsHRq/v7gTzU8Z9KCfbXk8rQiER9CLQ0FWcXi6yUJzsJZzo6iuUqqE+TiTuh1DoDS90omGsIQgpNAcZNiD9GL9ka8s9qUGb31i8d8HDIIAKEp6C/LVW1Wyjyp67oStAhEKOQfwJebQujgTnP7rWyBMNUf6RVk09ZxS+USgwqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Ck3e/lCE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Ck3e/lCE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YngQd1Fn3z3024
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 11:02:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738713736;
	bh=n9dR3JEhqnb9OApW3VcHCh5n2riOWy7LJANruYsyTtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ck3e/lCEXFFuuoAL69bUJWIek/Bsj52kXXFN9+Kl+6EcYVipvo8ygxrtNA4uMA1rt
	 t8UHG4JeGtRi/K1MhrhztJoZrDC6WPv9ESbvBEmNQ8sDfoqES0Q8Dxr7DSXZaCBG7G
	 FsyjTczGpcz21wcVTOqimjz4E+oHG6J5ABSwcd5nm6vx9P3rhr+I7F5ee6nNxnEnhv
	 z9AOwwanF4AZO/zfrRJwdBAtop2B8lrKQ394MTiFEPsrMHRBCh/a84XlYfYJhvWiW7
	 a9/g7PIXNWyWs8tHO/8KTFCI8uh3UXtHQ6dmZyKxzL7IUvqP6jfd3tt7ZgBam590Ec
	 y2AaxNBlxyPIQ==
Received: from [192.168.68.112] (ppp118-210-185-209.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A112C7104E;
	Wed,  5 Feb 2025 08:02:15 +0800 (AWST)
Message-ID: <114b92f993a1b5e2c77bbc91b42c21817af2874f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, brgl@bgdev.pl, 
 linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org,
 openipmi-developer@lists.sourceforge.net, joel@jms.id.au, 
 devicetree@vger.kernel.org, eajames@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: andrew@lunn.ch
Date: Wed, 05 Feb 2025 10:32:15 +1030
In-Reply-To: <20250204194115.3899174-3-ninad@linux.ibm.com>
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
	 <20250204194115.3899174-3-ninad@linux.ibm.com>
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

Hi Linus, Bartosz,

On Tue, 2025-02-04 at 13:41 -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> =C2=A0.../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 6
> ++++++
> =C2=A01 file changed, 6 insertions(+)

Would you like to take this through the GPIO tree? Otherwise I'm happy
to take it through the BMC tree with your ack.

Andrew

