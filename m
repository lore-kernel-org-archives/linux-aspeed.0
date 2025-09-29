Return-Path: <linux-aspeed+bounces-2352-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22899CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Sep 2025 02:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZm430hHzz30MY;
	Mon, 29 Sep 2025 12:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759114450;
	cv=none; b=dNvJTmGt9S+jcBkH+yBaT0qeE8PB4qaS4EzbtlhTNODzz6pRk00bPMuigvQDK/SLlYBuMDo0zDeXO2VzwwdjtHBCIjtMm5yoLdISdMxovZBOXUfOmrEdZBDLxjJDQMoQip/aXi4I2DlHgw29cVnMH44En964YdJ0696nAOcM+yP0L02dfaxPt48c7RouLXt5eUZ9ge0rdifIGhjkXjQ+G9H7OpBehjkHTpnHAJOpeSQbaWHlnYPXLrHHSdyaP3oK+LQlLvykGSx5GA9PNHpECBEnHgsqjgtLiiKrQkWexbXNl4AD/Lm84FeVVLyqVnT8K/Y5lMdMB+rLLksP+rs3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759114450; c=relaxed/relaxed;
	bh=brjNCibui1BunD75iFMB/zhDYfVCb5iddYtyuRU7tNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFhH0G52i1zgH1X3ko3ScTeRdS4Rm/m3cgfWONO9dYQ1MnKu0SGkJd5vXbaBw5HWdPGCZ+70/YH4JtgA0n2l3HUGWaOdLEXVDnOaLS2/4uo8eDhIxH4z8ONys09KKzGp9WYql226HGRtSlWdKwiozelZYNOvajItlfXHq+zFuMqbFF39BYCMrZNv9dnBG6jzUZ2Yw+emTVYteQIbceRxIe6RbX1/GVRTdYo7Mt4ctozVXX+Y8H81IcKi9xrspcAUGINFYfcCIwX3O1G5Rp+Ptrru1ct6rwy+1+feoirXVMh4NW9udNR2JHhEl7W36mLzpfM7hj2Q2yBuVZeigAYPow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KBaxehw5; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KBaxehw5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZm412kNsz304x
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Sep 2025 12:54:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759114447;
	bh=brjNCibui1BunD75iFMB/zhDYfVCb5iddYtyuRU7tNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KBaxehw5FTRBVnzcCNHJ3aAdKfn7YaIwpgMkzt/GIBNODs9itUtYsHSvrk8qN/Sf1
	 ymRxkd1wPN83MvkP0lVUV9pBS9gtIDR1oeksM8vAf+ZJ5/rXLFWCC7iwQhaS2hf1FF
	 Whhuy4kG77LxXwLheG8qLpvSG/QpBJWay9oeot/yR/VkiyaHCBESslUl+ZNWX1K+SS
	 7FvCOgaUXjt9yPSw9BbmgFKnAoIXsiz4EN+bivEoL/4PKpRbUWeT6PO1ce/DOZo5GW
	 i+gDePAUNVYdv9OObxIpt4lmuM6nKI7U0a5EpKw2wODRn2U6P7fRvktX+jHpHmEeQh
	 QfS8p0FuGUBCg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2413864782;
	Mon, 29 Sep 2025 10:54:04 +0800 (AWST)
Message-ID: <dfd8160f015b405623aa7a4b9e69eda2ad1c5df5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: yosemite5: Add Meta Yosemite5
 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm	 <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, Leo
 Yang <Leo-Yang@quantatw.com>
Date: Mon, 29 Sep 2025 12:24:03 +0930
In-Reply-To: <20250924-yv5_add_dts-v2-2-39a4a8e3c9e6@gmail.com>
References: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
	 <20250924-yv5_add_dts-v2-2-39a4a8e3c9e6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Wed, 2025-09-24 at 20:28 +0800, Kevin Tung wrote:
> Add device tree for the Meta (Facebook) Yosemite5 compute node,
> based on the AST2600 BMC.
>=20
> The Yosemite5 platform provides monitoring of voltages, power,
> temperatures, and other critical parameters across the motherboard,
> CXL board, E1.S expansion board, and NIC components. The BMC also
> logs relevant events and performs appropriate system actions in
> response to abnormal conditions.
>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=C2=A0=C2=A0 | 1068=
 ++++++++++++++++++++
> =C2=A01 file changed, 1068 insertions(+)

This misses adding the devicetree to the dtb target in
arch/arm/boot/dts/aspeed/Makefile. Consequently I don't expect this was
tested with `make DTBS_CHECK=3Dy ...`. Fixing the make target and
checking the DTB yields the following among the usual concerns:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dtb: ethernet@1e6700=
00 (aspeed,ast2600-mac): Unevaluated properties are not allowed ('ncsi-pack=
age' was unexpected)
        from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac10=
0.yaml#

Can you please address that? You may need to update or introduce a
binding document as part of doing so if it's not a matter of removing
the property from the devicetree.

Andrew

