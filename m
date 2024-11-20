Return-Path: <linux-aspeed+bounces-151-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A320D6E2CA
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Nov 2024 06:54:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtXCW5HHsz2y72;
	Wed, 20 Nov 2024 17:54:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732085655;
	cv=none; b=Cks74PLiNVZWH4FDepjsmu1hyt4CslR8x+ATAUNDaErWSg77xcZsUpIy6OwmmsdxeCdZ2iEQvyvN2f75kbtlFKJzWZKmDN14KC/zrpc3cSXpuqM33C/rsyMXyM2VrSgwf5PgCbPfr2+JZglzda1dCIN1mxyAFSaoqLUS4yeLQtCI7dbAHo4YRgs6fPqewpcuD4dlmiUQbUALvi0H5Xz9hH5ictPpXE0sEcAkKMJX8mDfZRm7gqcvNlxTSpZa8jP5dLf12HNhGUprxjqvJ+REYcIAGw1HbC9wij8bjnVaZ0Sb1sAGXH9dq/6aDOWwQZ2jwv/AgsVt4H6XC2QLT7R8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732085655; c=relaxed/relaxed;
	bh=ZGVDroxvGZaMmvO0knhWHMPeqQ4OtV04fIWg9bKNd7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW1JirEhFQiAZIoISzDDW7zya1poG3p0v8cBDaMSV0L7M6CORchRZYDtxqEn3m/Q2Tc8rxNAg1EQrnRtGjfPP14lrOedQYUh6ocIphOGsciiGaHSGFm9nZPd4tvonquFRlkFwa5cZZVYZW/LB47UIlHT6qfKEtO+O+K2Z9un54rlkDpEg4oE8CR+GzhTSZhNJGR4kQRZ3eeuJeqpoZO3QHYectrVPIVSAEtV7pnPsnWzx878tt4hULvaLWwkKypBWf8Go7M/U01uKpPMYvUQLniDtkL43m2/GpS9WbLzaeeIqxeeYZdwe3jkIxSnXsTH0cJu/rBZTssLG9DvvsD3ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hs0kvvOv; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hs0kvvOv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtXCV3wCPz2y0K;
	Wed, 20 Nov 2024 17:54:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EB6E6A429FA;
	Wed, 20 Nov 2024 06:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6954CC4CECD;
	Wed, 20 Nov 2024 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732085650;
	bh=yu0IVEbUHfOiqCOXFtKIo8jBF0HFsQeEynvGjcvNELw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hs0kvvOvB6EcOyu+DecW4JQwfXGTTJf/6WS3IneXaxhzQ7mCu7eid687fHls1LqR4
	 hVQKmoCeYYzKhg79WNjIfngDZv3Lasyw42DmaJ+pKXXILr8E2Y72GkStjOrN3dLe39
	 wJzV2dNuGPMZ6j3WyTBGBM2G9lei0aZYx3+q3o8Bh7SB3R6jHn5sRwEkZ3FpBHe0eh
	 895uK8IKGwN/BVbfBI2leAI85qRvGeXZl6Lgnp/8bh71dfExQPd1UM9XzlibNTmc8e
	 BrGtmWRZVvM/Kh9sWNyqMp2kEfo3hIhCYl21Rs5S9uy3vYoz+fIKw3UFbXxtdMH/D+
	 /A2DHGXLlw86w==
Date: Wed, 20 Nov 2024 07:54:06 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Brendan Higgins <brendanhiggins@google.com>, Tommy Huang <tommy_huang@aspeedtech.com>, 
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "wsa@kernel.org" <wsa@kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	BMC-SW <BMC-SW@aspeedtech.com>, "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>
Subject: Re: [RFC v1] MAINTAINERS: transfer i2c-aspeed maintainership from
 Brendan to Ryan
Message-ID: <37pcpov3u7oitszupqaw3upujy7fmns64gijqea5tz3m5zq4yy@stxttuqde5dz>
References: <20241115044303.50877-1-brendanhiggins@google.com>
 <ZzcPJ9sweqxLZOGf@ninjato>
 <OS8PR06MB75413EC87F76AD0B1BBA0FEFF2272@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <x2rt6k5hw2km2vm4wjnqihop3xcy3uirhxs5wvhnesxc2athgb@c2ra7a62mfve>
 <OS8PR06MB754190CEF8763CCF5CE89899F2202@OS8PR06MB7541.apcprd06.prod.outlook.com>
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
In-Reply-To: <OS8PR06MB754190CEF8763CCF5CE89899F2202@OS8PR06MB7541.apcprd06.prod.outlook.com>

Hi Ryan,

...

> > > > > I see that I am the only person actually listed as the maintainer
> > > > > at the moment, and I don't want to leave this in an unmaintained state.
> > > > > What does everyone think? Are we cool with Ryan as the new
> > maintainer?
> > > >
> > > > I am fine, depends on Ryan as far as I am concerned.
> > > Thanks a lot, Brendan.
> > > I am ok to be a maintainer.
> > 
> > can I take this as an a-b by you?
> > 
> Sorry, I don't know your "a-b" means.
> If to be maintainer, Sure, I am willing to be.

a-b is short for "Acked-by:". I assume you have acked this patch :-)

So, thanks Ryan for taking this driver on you, I hope you'll
enjoy. I took this patch into i2c/i2c-host-fixes.

Andi

P.S.
Sometimes you will see r-b which stands for "Reviewed-by".
Sometimes SoB or Sob or s-b for "Signed-off-by".

It's just a way to overcomplicate something that is easy :-)

