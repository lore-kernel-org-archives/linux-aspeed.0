Return-Path: <linux-aspeed+bounces-2457-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B281FCCD18E
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 12:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmrJ20sKnz3dC2;
	Wed, 15 Oct 2025 23:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760531970;
	cv=none; b=YJL6CoVRgM1farphdT6sHyWzGKBDKnqmONRHcEXaW9x0GTixWSOaL2Za6IkgRt80uQb0LPipDpNY1HHjiCiFcQjCTP4mjSrLp8/l3tJKWvUidIuXCx7eDe6y3rBtXltMSPhK5MnKS0/w6fzSw5u1NZdETg0vzk/L9ke09a/5H11tXJirGU3elwwUXq7Djr38O0Y3DbVDtojClND29krE4lIFZAbbSYQEgNyF66dh2PVwqHjJkQw2Nl3Q5F9WXkYBFXpmSwuJwkBW3mjE/iR58C0C70h+baA4hwWaHlUUcIVicFeP9yYA33Qj9itLeWTNBmYYMZq6CMfA1wwkebQobA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760531970; c=relaxed/relaxed;
	bh=FCzysB2PP/ptDx3tP/4JcOcfRh43sgPZpbfU/iP6tzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I63BAsVHEdpaukFLXZ/TIenNWEdzU3Q7WzLHUWXNNtswQgeEA5LXoSo1HY8Va4mfHc9DTqZtfdK4CnHNP2F5aIgQYRV42mg/pIRIUO2GfRBIVDOuJCDCOuzLy9Z5vjbeglwglc3qCHiUWMMSooTz6KGO2/IfBcPyFf6I7Rr/Y1KFoDbHExfeDn6DNujm7emSMRAj41yPVOrlFLQI/A4rWsASmgIgpdrlTdZO9YE099+bZQtbaXpcyTSfIf1Y+jpUIQzagInGgfurDlhAgCNm39dgGKnfhDUcDSZwj1uYOqa24FPMC7n4u/hijmNvbtut8Ze87PdZp6vxvWuKiYRirQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aADQLKwn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aADQLKwn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmrJ11xkgz3dBk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 23:39:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 841B6625B1;
	Wed, 15 Oct 2025 12:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF81C4CEF8;
	Wed, 15 Oct 2025 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531966;
	bh=O4vy5PSXyIGPiDBPil6snETDgyGJ9ca0rxgId+YGngw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aADQLKwn0O0etKEqQQ+te27f5Oajw9gR9Exbma95Xn1NrWBIo/sS40/JhgBFHYNPq
	 zuJi90mAD3JBoVaZWRht4dAbJvomp0Ynmh/1RwE4PtotlI9jDhsdDEv1JEMlbcpFnf
	 Geo6XGPmXHW1prv+ZSjTV3NAJYD2YoMYT0f4SI2wRAe/3ykfGrtKEhEVKTTtXlFnyb
	 XXv955yEJKhW5MqOUKOpmD3U5LoiTcNHisZrU9fStcr0ZtunBhk9kvqRSEZXsxHME7
	 oNmbA1ZXd87mLoyJ8aIgfeCrSoDcx7VhNgdOg7pv5sVvtAYaDZv5rz75Xcl59zPy/2
	 OOgbiVL/zBA6g==
Date: Wed, 15 Oct 2025 07:39:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	andrew@codeconstruct.com.au, krzk+dt@kernel.org, linux@roeck-us.net,
	wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
	joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
	BMC-SW@aspeedtech.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: aspeed,ast2400-wdt: Add
 support for AST2700
Message-ID: <176053196354.3197283.4565101517229903275.robh@kernel.org>
References: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
 <20251010080315.816628-2-chin-ting_kuo@aspeedtech.com>
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
In-Reply-To: <20251010080315.816628-2-chin-ting_kuo@aspeedtech.com>


On Fri, 10 Oct 2025 16:03:13 +0800, Chin-Ting Kuo wrote:
> Add support for the AST2700 SoC in the ASPEED watchdog device tree
> bindings. This includes:
> 
> - Adding "aspeed,ast2700-wdt" to the compatible string list.
> - Extending the "aspeed,reset-mask" property description for AST2700.
> - Defining AST2700-specific reset mask bits in aspeed-wdt.h,
>   covering RESET1 to RESET5.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml |   8 +-
>  include/dt-bindings/watchdog/aspeed-wdt.h     | 138 ++++++++++++++++++
>  2 files changed, 144 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


