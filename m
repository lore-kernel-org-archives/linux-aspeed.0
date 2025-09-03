Return-Path: <linux-aspeed+bounces-2130-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D2CA0FF2
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 07:18:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGv9D2d6Jz2xnw;
	Wed,  3 Sep 2025 17:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756883920;
	cv=none; b=LoeeKdHgxyZkC9+mWIr/+0TEILVaxXeAb+pgihQl9TF+k9b7ur071etbSUS4Bl6kXs9f5NvDSWsm40Q2rFDVLWHolPgXH93tuKscS3DK6WGE90Ln5oC9tcKALOfmJ4AjT6uZEUhgeV++6z0jPA28CkkBzcWJ1nFYCW+Col4DfI3Vgb4qAksEl5wak8exizPDsNdFFLv3SxJP92Gxwpel6edWqWV7mNC+8VhNze96f+Drjy1cXrR8JmpRMvDWcRxkazZ7SrdEX6xc8ymjLae+6AW1A2D9iWkY2pZlGmE6IfgBAQyqr8JmzPjA5/d48mAhpLwhzTB9fVSZB3ojPEFVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756883920; c=relaxed/relaxed;
	bh=uRXv1zst4Bt7hVDwEw6Xuli+96Oj2bzsZ/K5tIhZjAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/VPeGEZuMiO0v64GqOwRBFHnZG9DsQ46eCSfIUpNePHioX+rJLHClBbBs8k7t7MVzohVLm5NXYxloBg5OQrHcP8lyaiqQBVFW81N0EgiOYgJf7w0CZmRLba8w4fidqBsv/TRYlB7NMFJVulzcFfw2ys9AEOn3KamLLEOGTHYYnm+nriW8XCb/Bl7fTpAH8nyubMpn5rLhtg3Lx+zvq1ETyqsGK+nu12RZ80nGMRFaAtR9ZZFa3CB+vVmmjfg63+VZp/hWy0n946NUxHtqUyuwobgnY2TQqkxZBUvhSu0YpiWrZvrgxciigsI9CUSE2XnBztT70grqMkkcmrZkdaiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JWW4LWs3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JWW4LWs3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGv9C6m5wz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 17:18:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883919;
	bh=uRXv1zst4Bt7hVDwEw6Xuli+96Oj2bzsZ/K5tIhZjAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JWW4LWs3tbhpRxs8lsvP7o9byunRuzY8Y/VBgveoTqQl9Dirf9r8oPqMZnthfs7SI
	 JsaPYQi9d3XbOv6tZx+8BToq3JP1fuGozp8BYG47j9oV0wKXxe6cZZtCTu7p4iB3wG
	 CjE1xqbiJKOZeEgxdi74oJht354j7I6voOV/835gf9swmq65Miftl144m+DwoeiYw6
	 P/5yZsKogLm6udutuVBHBG8gJYk0qovUk6MEQKhzEV5758hXC8OnZPCM8qfPN+lfO5
	 GNOw8zx7T/X9CA9uHx9o9bm4dDgUSj4zWiXoii+2IP59VglNDGt1TlNYAY2tzzfFEB
	 0EaFEmy/Y9E9w==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A474B6FE7C;
	Wed,  3 Sep 2025 15:18:38 +0800 (AWST)
Message-ID: <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:48:37 +0930
In-Reply-To: <20250829211330.1336274-1-robh@kernel.org>
References: <20250829211330.1336274-1-robh@kernel.org>
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

On Fri, 2025-08-29 at 16:13 -0500, Rob Herring (Arm) wrote:
> The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
> redundant and can be dropped.

I had a quick look in the syscon bindings and can't see that this is
documented? The driver implementation behaves this way though.

Andrew

