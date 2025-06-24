Return-Path: <linux-aspeed+bounces-1558-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB69C77B7F
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 23:48:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRhVM0bp2z2xKh;
	Wed, 25 Jun 2025 09:48:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750808923;
	cv=none; b=PHdPb/WLpsE4Ri+q2pVyzme0wK9yrlqYeXawa/B5y1/zAHDXryHj2LhtOxq8pEwUN8IHDg9WHLbsyz+lurDuLghpSPCCHj1Tkr+AGYvKnKxZjvXRmObOMc+a1dqVgbyNgMUOD0vZ3esiHHrxpInQf7XnP2xjtEOaLpnZ7sMpIZ+IFcOEdM5mabi7Ii4vSI34CgVNB06lzYoQH4YjrCuzC03FgCtuQ9slp5WKu9WrMl32pIlpJVzZiPckyE6qREL2JtkUpwyys7dqiyWD0cCJzuYTK/gCPHIv8YjQU+udTXyFSRhIB0IMHjoVfWNuTZQdczr1F/KPPDeCEMDinU6hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750808923; c=relaxed/relaxed;
	bh=AxbrQgbI9Hp0lzSnXJ8VQEX0GBAeXjw4l4FNRJQO2nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nww+0NN4QRUjl9LGzK9nK0A0SfnKasRSychQM7RLON0YphRv+AUxLIpnBTiOshdNSfCwwXO+k2q2WKkdDvDAgv0kAo73byKvAT5EkNMktKPl3WOWDFVAhUFG/PxcQFZO92HdLRidkHIZUWLOjsu1eql2aGQ9qnc53agkqPjlFC+SzAHb66eK4TPUa4SI++70mc8vC4TTn1twZ1fRDR7sR/unU2SfAf7NDHus0lQctmUNVKx20Xw2wWoS42KiX8b6olpBIt1LXvae1bSrlMreKwS+vRilxWxGLXQKrfMDPmuiCVKA0elTvT4BWAuAj6woiV8LGiTxCx0CgzNdcYuYMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NEm1SLbI; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NEm1SLbI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRhVL2Fgtz2xHv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 09:48:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750808921;
	bh=AxbrQgbI9Hp0lzSnXJ8VQEX0GBAeXjw4l4FNRJQO2nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NEm1SLbIZEjsx9Krx0+hgcKI6aHpzW9XZ4tgOiPgvSg+iO/oAYyxW7hL4fTTI7tPp
	 tH9Ks/nFlUv3hRMH/LxC2vD8ceGkBQwWMnvfBPB6tpZ6xAcfSxwdOGeCMmmMeCCYcx
	 I49F73Bthcw21cN1pswCmEh2Pio8p3xVy+YzI+oe1VyVpDr9UJ/38ws/CZi+Ss7kr0
	 Tpz2VzOe28Kwf3I9goMKhAEyrS/VqnTFBdVDwX1mrjNrukG/OqAUJd5T7xZVNz8ELH
	 S/ZdATsir6Szpk5H3p7Ye9WSWWpXurzJ2O+dwdGJm836rRne2aLBBxfrxMSsECZMRh
	 kCX1ENFJV+7GQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4057C640CD;
	Wed, 25 Jun 2025 07:48:40 +0800 (AWST)
Message-ID: <6a787dfc8bfdd56c564c4e2380ea7ca902bad090.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
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
	 <leo.jt.wang@fii-foxconn.com>
Date: Wed, 25 Jun 2025 09:18:39 +0930
In-Reply-To: <20250623-add-support-for-meta-clemente-bmc-v3-2-c223ffcf46cf@fii-foxconn.com>
References: 
	<20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com>
	 <20250623-add-support-for-meta-clemente-bmc-v3-2-c223ffcf46cf@fii-foxconn.com>
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

On Mon, 2025-06-23 at 18:29 +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
>=20
> Add linux device tree entry for Meta Clemente compute-tray
> BMC using AST2600 SoC.
>=20
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>

Sorry, I missed that there was a v3. I left some comments on v2 that
are still applicable on brief inspection:

https://lore.kernel.org/all/0f495eec39fd25d71a59a56876f6142e6fe786f3.camel@=
codeconstruct.com.au/

Andrew

