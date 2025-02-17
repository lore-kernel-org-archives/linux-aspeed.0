Return-Path: <linux-aspeed+bounces-748-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A1CC02198
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 00:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx32L3nvpz2xt7;
	Mon, 17 Feb 2025 11:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739751018;
	cv=none; b=PgppdEHyAHBGIMXnNll/lBRg7cm44TCwOf6mtpPhxNIeAMUBjq/rFM87+P0BXHgq5pPBTAgrPCl4Dj2UWpQYqI/p9sdJ3OtS2tY0nKULBano9HFj0C79SsItBsSU30B/rfpZ6O1J6FUM6vPECUaVeH5nakEe53c1LQom06k9JSvopUm3sJ/66moB1PYkbhFydWFcV5eBNilVQOwD9Hjv1xSVW94y9pnaAx1CmIJqy1tTmm75qwcKecJcdmWbyLjZiwNBoCaunNlxAVPBxhJYbKdkpXiQrRx9PcBZ/VXXbpw2dt+FGsqi7McQOlWFDPwLL3smQhSuSl911elRp/tbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739751018; c=relaxed/relaxed;
	bh=JcU/Mrdr18cGs3dTnCLq4um8s+90+rSXo/XjDVljqqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AwqGuphJByvs8DO3btvJXCXEBVP+oTvTp3qbInlLs17RRVRstbLWZwAf9mOziay3Jf9H1tFqmyU9NngOV94KU41kbnhP4P8dU5lyDGZQYz7j9nqLr/KRfF5SkXgq/k4srKch/IkoeDwYwNMTSaB3NgHTmINqt8afkDxMiL1xaPWnGnkbXus4ZfMuDDpTX2JzB6TY7XDdBzb/LDLe5aT2oXmAnUAhZuquSmRZnqFhqrUKY0/SUUMPPGBDzkjE7Rgq8064Po5k47TpnH2uIfLZmZuabrOm5MKqIQ9yHXujpAVCDwkhKDB9xPbQaq2dy3KrMFuJp1Gf9FHhZ2gJrceGwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FfU3qebS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FfU3qebS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yx32J6VpMz2xdn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 11:10:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739751013;
	bh=JcU/Mrdr18cGs3dTnCLq4um8s+90+rSXo/XjDVljqqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FfU3qebSurQNgcxzYBYi8q46USfa5cym7WWDYWfYGlOG+JJkETsZRLR5jcu7jDH+Z
	 VXszDdoBHfNr9qcdQGZVmwlHuy/EHjbLACc06SRFlOWNrDOvbXuR1Qk1FNrdUkizKL
	 ef8/noP7BTqMblsLm3qEnKxNkoOvVv0uZNGwyL8pQtig/RUUK7391c8bwuQO4UEHy5
	 LQWGMzlQiCc2L2WMms7mGCGX5ryTXMKnI0boqITdXMqjv5oBD9PcaS3mjWu64VSvCV
	 LX6qMGvh/EYLaRvLLV1DKBIk5AfPmvRl9VOWnG2H2ybmHzoZdvg1ZL7yOyXIAz+u8o
	 2FKb+V+lCD7TA==
Received: from [127.0.1.1] (ppp118-210-174-88.adl-adc-lon-bras34.tpg.internode.on.net [118.210.174.88])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C910C72F1E;
	Mon, 17 Feb 2025 08:10:09 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
References: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: remove unused
 ethernet-phy node
Message-Id: <173975100971.56771.12087846830640085961.b4-ty@codeconstruct.com.au>
Date: Mon, 17 Feb 2025 10:40:09 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 13 Feb 2025 15:12:58 +0800, Potin Lai wrote:
> Remove the unused `ethernet-phy` node and the `phy-handle` property
> from the Bletchley device tree. This fixes warnings reported by the
> kernel DTB checks.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


