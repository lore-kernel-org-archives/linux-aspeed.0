Return-Path: <linux-aspeed+bounces-1864-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F419C87FC9
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 02:30:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bstNV1XSQz2yKw;
	Thu, 31 Jul 2025 12:30:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753929034;
	cv=none; b=iOhYcd8yUV94gH5w4UP6SzOrVSWtVQgzNevrb4GfvTIRtdi4a5k68udqxBHiIGnyyy6BlYN5AE1+NbgAZGcB3uXG7ffS79ZiXkcuh/np/+2Y98HPneHG04vXm0Vb2jJCs32zbmH2VR5+nMoaFXiePYYS6uY01g56FqIUMj9vYsQsia1NQSSgcjC2hAMYCOhIyg+TUFdhb2pbJaBvxEjUOQzhMoOIu35I5wGTbtBmD/T33Q14H1MdNuj0HU+QwskWLCkSolMwE2gxDKVMYIHqkqMZv5Lpgr1oEiiEYhAhAugtGxHgvXq2vtVSQEDNU6LpBKB/s9J53vLH/n3Fei7TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753929034; c=relaxed/relaxed;
	bh=8jEKI+a2l5XlR/E3JP8s37RLYXVe77DyLwBFBCUJqfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZFVEaxxBKjxBWAr18oUEOQp0u6pnNB4xH72yvuqS9bssFyUdLdoTw3Pf/HYYjezjSqbVtkPaZA99EeN2kUXhSYfdHd3UeHI/HxilqG3KVZBrF5kdpzwEoUdnSRuL2WlY4m5+/ybllHIpfq6BPwhDrsMb4jj2DG6mLYUOVwqABAAWTwwGbZ0nrYkhMyAHybl8Wc+KdWxoe8q0WdzuKyYDJO84WQD48oGrGSh4i/+WtyHMvTihTjj1wV8VnEBBp08h5KM35syzPfyygbba9H89c8lHxFQQ4AxnZw0eahGAQOWxvHHUv6gCeve45kj3WPDRyAELHKdT5Jnmp/ly2JPRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CyfgZAWw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CyfgZAWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bstNT3n0cz2yF1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Jul 2025 12:30:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753929032;
	bh=8jEKI+a2l5XlR/E3JP8s37RLYXVe77DyLwBFBCUJqfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CyfgZAWwliTD+nM38ntQktYQ6EDUNpi1cSwNgQDwKa6MmNl8SVPJGeIz7K9giG4Di
	 e5Wz6neH3xPuwqfYdFUv60ksXRiZsq9DIWMeRGARjKmMSdZB+KefgmezJ/loQt1HM4
	 iK4SE2HpyeyLAh+aYVOdZX261BuuFO8srTPoVhLfYT2mulmzYC4qglZ5mVdDxdJ9I+
	 PT9mA5lJ6PMe9SjzCIrd+GYCnb7aGt7beSe5aMUDc2CtfgHJxMt4dfUnVCbxHTn06d
	 BJViD8JZXtPjGJwcNf/aqlBHJu6C/f1kdnQerG6xTz9ECtH9+OhSUiipnj48R7qtKj
	 O3gdcNXzV8jhQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B881069374;
	Thu, 31 Jul 2025 10:30:29 +0800 (AWST)
Message-ID: <b32a9de1d591d3012240919d23dbb22305cce6e2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 2/3] ARM: dts: aspeed: clemente: add Meta Clemente BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	bruce.jy.hung@fii-foxconn.com
Date: Thu, 31 Jul 2025 12:00:29 +0930
In-Reply-To: <20250723-add-support-for-meta-clemente-bmc-v9-2-b76e7de4d6c8@fii-foxconn.com>
References: 
	<20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
	 <20250723-add-support-for-meta-clemente-bmc-v9-2-b76e7de4d6c8@fii-foxconn.com>
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
Precedence: list
MIME-Version: 1.0

On Wed, 2025-07-23 at 11:42 +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
>=20
> Add linux device tree entry for Meta Clemente compute-tray
> BMC using AST2600 SoC.
>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>

Aside from the usual ASPEED warnings, I see:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@34 (maxim,ma=
x1363): '#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel=
@2', 'channel@3' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max136=
3.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@35 (maxim,ma=
x1363): '#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel=
@2', 'channel@3' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max136=
3.yaml#

Can you please submit a binding for this device, or drop the nodes from
the devicetree for now?

Andrew

