Return-Path: <linux-aspeed+bounces-1510-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21284C7115B
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Jun 2025 06:25:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNnXx55dmz2yf3;
	Fri, 20 Jun 2025 16:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750400753;
	cv=none; b=Dwrbex55ZYedr4/qCOqYm00um55xvWn+B/pHqbuCmI1LcAJFKiqC9Scpjix3usZGocmajqLaNaWb7mEfb4lQ6CVOo9FfGznzWSXLsGmkTMaErpoSX54A2pRssygWGxhT6/lt482lZ1bg3fMYyZS5KfEV434nCcmCiZoOx328r33pIl7Mo2RP1srnY5c1D5Iz1mwjYRGbEkOEPNkTVPE7GE8t6N8o2Sy8jzP9ZOe+L3hu8eD1mp8bZuspVuNkPC/MZjGWqGPyLA4S5w7jzMaCHDx39g8p2fYdrBo1A5MTQGLviAMi91FS60QeEuRTLaaSAWNTsa4+OdWit80Xwvd0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750400753; c=relaxed/relaxed;
	bh=HeuYZMsC9WsSiMUpmqqe0M3z0iwrxrWn7R8Czqja7Co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Noo8TaE2OxnHOyLBJ9oqnznYtD0jMaNaggryLuoe6alTFORyYqPn6gmy8QaKK7SCivXrY733l/5lwTMAIJ8aToUE3oMvYeaxaaPh1c7oB2BuVHnu2Ht9UtZIEpnbYgJfopnUYYHN4HIHe6KiptWPSRUs8yLr23oU+/lsedH0di+ebeH7DEQgFaTyj54AVbsZdUwMXiDbsrdkAqq1s4Q7vM+RiMT3Izk+vtCEv74ihDEa0d5UuKFp1AUx+2M6b9Md2GTPoJ16S2ZIKZ+JpLb3HhEiVZyy6tt1fpqL2URlbRZaT3lGgmV/XwMQqd7xGLS7lblKTZvPg67NhOI+u+hVPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KXifEzUg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KXifEzUg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNnXw3Jnvz2yYJ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Jun 2025 16:25:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750400750;
	bh=HeuYZMsC9WsSiMUpmqqe0M3z0iwrxrWn7R8Czqja7Co=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KXifEzUgUP5oogEUgfxYXUvo0+ZE4B6Y5AjhwTwC0AykM3w1FC+7pF+jUWSMhzefL
	 CivXgonieQSyHUacztzurorFb4fwwccraax9Co1aXrXO6nuhh0NNBmhPqvfaWTZdof
	 SPZHhVJmY9U6ePBcvZWfHZjsC46HUTXbBhf6SffmywGIztUrqb/+dKpzmCDZThHs0f
	 wBHMdv6ljIYj+KEulcdDMQmqfxqi++QThGq6i+pjVphzUPvpGBwNCPVCZKumLyVBpk
	 7WN+lIe3s/FXcT9Pbd5Y9tTQntf9e4iXVpxbvy6Wxyo2ws8jgJYWMhpgyxEFy4IOqc
	 bV7vT2roNn1ZQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 44C7664426;
	Fri, 20 Jun 2025 14:25:46 +0800 (AWST)
Message-ID: <8120f04c23f14ac48671a0af45838536a4600e98.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2]
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
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
	bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, Leo Wang
	 <leo.jt.wang@fii-foxconn.com>, Conor Dooley <conor.dooley@microchip.com>
Date: Fri, 20 Jun 2025 15:55:44 +0930
In-Reply-To: <20250618-add-support-for-meta-clemente-bmc-v1-1-e5ca669ee47b@fii-foxconn.com>
References: 
	<20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com>
	 <20250618-add-support-for-meta-clemente-bmc-v1-1-e5ca669ee47b@fii-foxconn.com>
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

Hi Leo,

The patch subject should not be the path to the affected file. Can you
please fix that? Follow the lead of other patches that have recently
touched the file.

Thanks,

Andrew

On Wed, 2025-06-18 at 17:40 +0800, Leo Wang wrote:
> Document the new compatibles used on Meta Clemente.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
> ---
> =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index
> 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71
> 403f897681a98 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -81,6 +81,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - asus,x4tf-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - facebook,bletchley-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - facebook,catalina-bmc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - facebook,clemente-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - facebook,cloudripper-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - facebook,elbert-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - facebook,fuji-bmc
>=20


