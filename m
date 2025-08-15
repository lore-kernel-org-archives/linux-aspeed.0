Return-Path: <linux-aspeed+bounces-1967-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B357CA0EDC
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 00:44:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c33K75rqRz3bTf;
	Fri, 15 Aug 2025 10:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755218667;
	cv=none; b=dDiiC7fsn1s/p3cfYPbSXYYdgkF7TWUvMfQWnT2wH4C3v7ahmq+J6h+QQeuJny/x3ltgZ9hHQwU64c0SKwPoCx/baBUnhwXU3zMsZbhgQZcipe6y6RgSSLGgROSWsmepWnCTCh2Q3AeVb6OvGJdHpT26A0FtSwZaEKMDtxMB0G9TSTF9HZ9wvE1LAoG9Ug53iMpnaTAtBv9VdHMzPk9TZePIk9P1amuibP2Q6H9xg3CoRFzBLUyK/czN+gxhRAXfBhBXp07Xtdn/Y0TmEkrg3ZOe7LENLcLq0J+Z2Q90r6ORYG/R+2xgla0IeGwGmt+4uoN9krLaReM41K9B2UpYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755218667; c=relaxed/relaxed;
	bh=JSAGEycEpcf5H7+zsKm3/4zBAwQ5+Zk/RKqQOluMe7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+qg9tFqPaRS/JUi5scr7Nx+1GKn77M2vEfLsZCucYdpn0knBS1XqNzFja0ehDPkHdpvw4FB4JVDqOXm414uIv0wJH8QsKweJ2QtoZu5upubrLaFXbSFo+KM8/Sp3R6VGVOem/cXM+T6J0mjchKCyILTnFA9U2s9EG1OjECVZkNLhEq00YrRdParAnON1YQGkzpmPVTDq7MZ8gt42dtI8Ne1J7rPKUYOvFTr7W4eFDl5fnThXPYry0OGgiv4KGt/LgyfXZ2s3gIt1VshZ+pnE9h2z/6qAHTmL3iuKkenOFoUM731pP0zrBsHd7K4ZXQnwY/m4rDJrMo+BXmPAltwiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ql1GX3OS; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ql1GX3OS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c33K660wLz30Yb
	for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Aug 2025 10:44:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BBCFC5C585C;
	Fri, 15 Aug 2025 00:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E822C4CEED;
	Fri, 15 Aug 2025 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218664;
	bh=tCgQh7vbWR7GLS7Dvxp6J8vUAFhtzPpoYfT8KURAxSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ql1GX3OSEWLcHuef9Y/XLmAFF8GNU+IRpSHY6fPST9UZ2gaW5ApaCUmrNuHofKuB3
	 BHILxtW7lF1O8KHMxdED1TAS+rBqswRL80IgOb+dm4vAGzHVBRx/df6Ir03mHIj0tV
	 ktDXMAoQf7sxieDkiYn72DxwZnfo8RPb9JDV8KkH22j3Ewkzv6LGA4O1VUHa/ctnzj
	 AdGzYXdM+hqWUNuklri7btaTItUT76daFmXaaQ56FkwWOUEl9AUOpKaAqlq1lWLFNx
	 gjBuU0cEcjbcwISsa2ohBLm3FUQJQH7OIq7eYQZKpzFOHmd1fwTZu/ExmdF4A6khJg
	 8X8av7VnZDnwg==
Date: Thu, 14 Aug 2025 17:44:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: Re: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <20250814174422.17ed3e32@kernel.org>
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 14:32:57 +0800 Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the 
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to 
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration 
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay 
> properties for each MAC type. Corresponding changes are made to the device tree 
> source files and the FTGMAC100 driver to support the new delay configuration.

First patch doesn't apply cleanly, please respin.
-- 
pw-bot: cr

