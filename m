Return-Path: <linux-aspeed+bounces-2258-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96AACAC5A0
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 15:46:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRjn11rTyz2xcC;
	Thu, 18 Sep 2025 01:46:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758124005;
	cv=none; b=dD/4Dc0hGYOSit5uQBCeyZNvEaiJ2bU2FcCY9TW3qgb3+NuUz9fv+JSdhYTkHZZbsGf0ZFuVKUydAJkKQ6PnlqUsu+iD2ZBX3NmlDitxf1x+i8PeblPQ13R5B6AQeKK9CIUOrwAXoTPawWPjXKKHLulOM4+GRfXqtdqWuMFYRuIOxr0wKEYtBtXIwEDM9U7xglRbOFgrwag6IPVs8e+ygDCq/3PR3hrYgR2F05WUl5MwkCnsnr9S3mnm2HXDv39kwZdImgXmvu2bbj1q3dmdSFQUNMkOxbl8lR1QG4ogsICSVlfDRVYCF0QRQjfKdw3xI7AOedun5y2Q1OFqv2THOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758124005; c=relaxed/relaxed;
	bh=rT2QCWg9XZwSjCGMVtZ545RxL8Hpt8iZN06Tn78APhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ichPPNczqA/yieAIZujGnPjEDIV9ob2K2K2pQk/otqys8XSXhVsK/rA85rgeAdvnvJM3at1Ns11a9+uxRc43yQxTFSqGQHgUBRx1P/bEB1ro+dmxl+YWo5Ju/R7ryCnrSHPP0odBU6wEBEaeEqIFVVJ1QkGAVrY3Fk9VV6Ov4iLDuB/N+bn6x+0AulrZ+cOBQOU7/NofbPE0RssGmVHKJnIiVBGLeuMX2Akw2ly371rKcXKzkWNi379AR5kVBqCXvcWxoigWJ8Ya+qiv8SdMG6HABhqaaDYYxRDLb0G9RzU7bwtKrHc8wxWi351g+oUfNFY8CMPWlSHfjR+fBuyhxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iI+1mRIy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iI+1mRIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRjn01B8Yz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 01:46:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6BB91601FE;
	Wed, 17 Sep 2025 15:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D9C4CEE7;
	Wed, 17 Sep 2025 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124001;
	bh=6Bw1RkNnxmymT0g8hsrq4Crs2zbCjCS1d/QHroKXP8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI+1mRIyqnrTTFpv+u/X9tFIFJ2hFmM+9OyzYI3GKmwVyVrENN94J4X94HTLiCRsi
	 StHHkVxQas1nZUHlhNvjslrhz1WFv+frO24AgOl4aB+pOip/VpulOKipXdleGYjo2s
	 e3on62Qe7hiiYpEFWy9KYnrEGndbU4zGNvA58dsNrOOPjTraPOJtwRPDtzi1mM79oI
	 5OK1P0NMuuHjqLsJzjQpdbZD05KccsL6xYx6q9QZCUbgecxDx1QqR2lwyTyo9SdR2J
	 uWNUelpbsYQ84xbAyGH2fLR5VRUX+7o+nvDQHRRHpF53nIltiOS1dsWz0AsYVKUaH+
	 TaYLBtKqMBheg==
Date: Wed, 17 Sep 2025 10:46:39 -0500
From: Rob Herring <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	andrew@codeconstruct.com.au, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v5 2/6] dt-bindings: arm: aspeed: add IBM Bonnell board
Message-ID: <20250917154639.GA2117942-robh@kernel.org>
References: <20250917144210.160051-1-eajames@linux.ibm.com>
 <20250917144210.160051-3-eajames@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917144210.160051-3-eajames@linux.ibm.com>

On Wed, Sep 17, 2025 at 09:42:06AM -0500, Eddie James wrote:
> Document the existing AST2600 BMC board for IBM P10 server.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

