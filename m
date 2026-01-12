Return-Path: <linux-aspeed+bounces-3282-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C749AD2502E
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 01:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqFGF0gc6z2ypm;
	Mon, 12 Jan 2026 12:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768181493;
	cv=none; b=epNPMfu+1f21ks2IYcRI+jdcdzAaIcNaXSaqWG1vZ9TplmkjXj98SZjJJLA9DkRAwACdTHZRvpmjUF/fEmE+C7piPnd20bE0KEtxz5xjZRd3E3YjKQM1PVl/UBlcpSTfysMJ9+n5rzki9yg0yboisA8KvvDjhe7pZRUiBq5wEXYEpMflb2kHf4eAoRX0keH+g/nj8piyq+FiDSg4n3itGA+GvKgmvN3iwSvLM2GC4E3SekEVhku9HXXrwbN6X/fhuoDFUX83lpwHAGnco79jumysg5CgXg9604UubdOSxSYok0V3hQiF2nPsamuYAZfrEVcH6begjBAff4rkT8gk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768181493; c=relaxed/relaxed;
	bh=2EZGAGj4mxKMc9TBwMP5s7SOY2mvUzQcYppNZKTDksI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fE2V4GgjwAdqK9GiXapmKMo2eGvIALpBUcAVqihQRtkU0Hzyp6tl6BObOFCgInMOWQxWj0b12pPr+Ax1Kg6ufT+tPrOXJheAJeSkjJ7wlOzG2pImoiWBo3OrLGBOn/f7fB+/dE+MyhZaiYilO2MZzsKIQHpEDukyDw9HqoeVDjz3uEtj2vrvL6l8OUeOmQpP0VW7o927y+vZZXkw+sPlJ7hDP8zTFbSKy090l6eDCafg4GVyrfuRQKo6+G07lQr8+0A46exznRP3LKmZsvtEGbRlRWOrcLieZ0XKJvv6L7L6EOXwMGvdwHhKvwZx0Idr+YOw+JedQj3COagx1F9aaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XNb12peP; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XNb12peP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqFGC6TY3z2ypV
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 12:31:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768181490;
	bh=2EZGAGj4mxKMc9TBwMP5s7SOY2mvUzQcYppNZKTDksI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XNb12peP0C2TGNPDv/KF3sxfwLnepAAdkGCXC8mcqIoPCGRDjpSEE1fvTrj3Kr0DT
	 pcQqPtHn5sOnUdZ6gYd6bcqsbU+X3/mlmw3d9IHj8yhZ1CfvcrieWYE7iQ6wKvyaXy
	 A3e4FTeGhvbo1TzULng5d0A7bPT0Xv4AwRDB9HSt5yG4Ty2nj3/DczaT1P09fWgQZo
	 1/rA06eq2IDFJcKkd9K+gzKZmFCXKuEtNBZM6Lkjpe9RwPNiQ7GvgqqDURqqx6n6wu
	 sJZKvG7BI2sky36rOcy+h9oga5nbq/Y9pyWJizLkIkG2CHUsdvBzbK8Kfbl4i85j1b
	 bCijTcvJCj/vQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 35AD6648B5;
	Mon, 12 Jan 2026 09:31:28 +0800 (AWST)
Message-ID: <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 12:01:27 +1030
In-Reply-To: <20260111201040.162880-2-anirudhsriniv@gmail.com>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
	 <20260111201040.162880-2-anirudhsriniv@gmail.com>
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

On Sun, 2026-01-11 at 14:10 -0600, Anirudh Srinivasan wrote:
> Document the new comptaibles for Asus IPMI card
>=20
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
> ---
> =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 9298c1a75dd1..b2d20341f8eb 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - ampere,mtmitchell-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - aspeed,ast2600-evb
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - aspeed,ast2600-evb-a1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - asus,ipmi-card-bmc

It's a bit bike-sheddy, however: the pattern tends to be
${vendor},${platform}-bmc, but as the platform can't be specified and
the card's function is the BMC itself, I'd go with "asus,ipmi-
expansion-card" (I couldn't immediately find a useful identifier other
than the product name).

Andrew

