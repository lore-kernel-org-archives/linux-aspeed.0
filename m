Return-Path: <linux-aspeed+bounces-1116-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BA8C36002
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 21:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKFxf4rFxz2yT0;
	Sat, 22 Mar 2025 08:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742592678;
	cv=none; b=CGVqfTIIfmXXzvb9IeYvnn+S0M0G2/I+VSyN47DnEYS7xWdunYsCIlRM6aClCIg9ntBFxL7DOdWcoUs0ilbikYaT+F6qltft258Hg8JFbG2RPRmmAwa2lUi4bTLtPFeDr6uNEovBpiiuhTjrLccw7aW0/1Up2j5FRHxaPt9jHHgaOb/OR837OGg9Rx2OkNNub63iVr1q6cT/b1qWXBrglFFk32Vf6fk2ke3pARw0I9+t3VrkCf6s3DEaHx18nTilp10XjVVL8f/45Fqw0UcIIZLzSV4tbkwaEAuOmwrIeoA6SI+uNQ/H1GV2Qa3EAii9l5Uwxsyx+ttRU2wu62HprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742592678; c=relaxed/relaxed;
	bh=exPX9nLYJApSHjK3I1wo8x7e7OWj82voDG7MKeN/asQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuPXSpUC95X8d2kBkJYZV1U+1rZzGAxs1lVjgIzVeCQmDk/zl2FaUQcuCbNzds7MIAfD/tpUEtLxj3BgeBFUfJnMlw/Wmn2MD4TzoLmike+dKl014J8SI0PLiqJYfiMq7QpxB0S+eIJps7qOfKb62ydgDp4YRFKZqKnp0RYK5gSCpvybYymln1jo5NkyM6EtXZvabeBArVDbq5oQKSav96xlbxB+8n0RzKBqPMjiHcgqBTCT0SEn3+euMyU/gvBPkP7jWbJ41o+H0bKUxdsuKB4yaLrk1Xcj0+KmB2YPH0c+jwOLPaBghoW3h73msf73vLwzrzWWSL3EDgT2ur3o3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=syEkVpux; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=syEkVpux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKFxc5cwDz2ySh
	for <linux-aspeed@lists.ozlabs.org>; Sat, 22 Mar 2025 08:31:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8603E5C3A57;
	Fri, 21 Mar 2025 21:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B5BC4CEE3;
	Fri, 21 Mar 2025 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592673;
	bh=+f32SRn/DhI5x9BgYlZ2PYxvre6UQhJsBBuq0rXKjAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syEkVpux+zdu6y0+JrMVHXsj0id+RPBgMSJRyjmL+naIk5mt42IQWs6Dd3nAj+928
	 KBLOzfA12Nwm5/7lbqEvDsuKjgqQnN7A49uAgr+JDdLUoPjEfvv6CJxQbq6StoUHVW
	 K/2wSMPZhEffNaZV1hEZAcAXlF4NU8TyD5pMDqJv8qPo+n9UfaFvx5VWijvmQw5+1c
	 Z4pfn3XllVxigqeLX3+gX1KhKAGLUgWf6cPdH6KKopA+lEiFIZDftk7nizKc1yz3S0
	 iwcyhZ6RgELBGZw2Oni5ZMUbxyuGNgCtIY+Z4Bqd2e3LJCusxE3U1urKBu+q0DU5nQ
	 86W4XQIgRjVEA==
Date: Fri, 21 Mar 2025 16:31:12 -0500
From: Rob Herring <robh@kernel.org>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20250321213112.GA4137938-robh@kernel.org>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
 <20250321123731.1373596-2-jason-hsu@quantatw.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321123731.1373596-2-jason-hsu@quantatw.com>

On Fri, Mar 21, 2025 at 08:37:30PM +0800, Jason Hsu wrote:
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
> 
> Signed-off-by: Jason Hsu <jason-hsu@quantatw.com>

The author and Sob don't match. You need to fix your git author to your 
quantatw.com address.

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..a86b411df9a5 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -87,6 +87,7 @@ properties:
>                - facebook,greatlakes-bmc
>                - facebook,harma-bmc
>                - facebook,minerva-cmc
> +              - facebook,ventura-rmc
>                - facebook,yosemite4-bmc
>                - ibm,blueridge-bmc
>                - ibm,everest-bmc
> --
> 2.34.1
> 

