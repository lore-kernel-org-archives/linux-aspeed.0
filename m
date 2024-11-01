Return-Path: <linux-aspeed+bounces-66-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01633E6F06C
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Nov 2024 16:12:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xg5VS4Vjyz2xYw;
	Sat,  2 Nov 2024 03:12:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730477552;
	cv=none; b=YKn8lEqzUAutAYEhym1UPaWomUnN3NEI221GseycS5gozx0BiO6U3edGUKx12rd3/g4JqixmdJ2OfoUgoEkYf0XCc76xEs3krijn6HCro4gjm0XFt9/miCID9e6nco/z4d8xvJAyHszgIS79VIMVfBDKN3eC4i1ORx++cTWgJ6dKWX4rxFIUlsLDWI6222qZWuMx89R0ztJ+i2XX8uFthnRAwWqNJgE5wrYpS2e/BIChMi5vhO2UhdVOIh+PGGJxQTdm7lck4w1/57k5zKe6ZRaIdw4x3mYsmvyIrtybKXeCqohmJvyUx9Vpp9hIJejaD+HEk88fXdB08PN10i0kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730477552; c=relaxed/relaxed;
	bh=bvXXKKirgYBhDMBn+0k209YUUu7Ka/nZ5P08CFtOYmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l8aXmVuIicZxmMlZhexv+zTHBS5T0Co7oz+3yN54aA29tsBr9O91jkcON0Krg5VEUWjIhjMvwluF2XB1xGYX/IaU7qCNK8kGLppcZnEFPuEC3SJOREXoi4m//D7WpJiv9ct5cD2vsvpcnzC5oxHjEjgvKxfW0/lzEm7EyDHoJY1LhnyUrOyvXq2+LzCWgQityioKzKUI0cDyB0Yh1HTZIyXfFilRX5/4Nwx7OSdsW1ZK/kfUAgL4xs8AZd5y5BVwTFiVNls1gXeWOkFn7mgujF8LdWHPNEn43hT0tSJWy+Gjw+7k4IADQIrYed6qUmXZAVnMAaPTPQ3U33uy/sZ4vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dmaX2Npl; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dmaX2Npl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xg5VR3p5Lz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Sat,  2 Nov 2024 03:12:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7EFF0A44587;
	Fri,  1 Nov 2024 16:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6598C4CECD;
	Fri,  1 Nov 2024 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477547;
	bh=uwXUT5FtHSsLYjY23SN+coyvRK2O8i6XV0K5dlhp3Qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dmaX2Nplc9QxCZRRY5Fbnq/PxjXcgLVPzmYLgxlaDO4rna64XDtqCOrxVYr0J5szB
	 Npqtvz8dRNAd7ViCuk2MLHkGA7eTvnXYkKUaQlwl3qlrx76/ULmaSEoLyntGzpWWPC
	 KJ7D4NrcX42+sZjs9FbV9YsttI11hzwmwuIP24o8vvdU2uO/EfBI5jRrX0ShKM6SfL
	 6aEYFNomlrRPUn5PkorX0hSmyFwwDwTPvpOTSbTPA6cUxo7FZT0hr8efh/D4opvx+F
	 XyqwQvcAxFIennJEMO7aC8eKS25RdXOLLlevMAiDhz7zVQbNc5xd/+eliz609Z2B19
	 Y2V5d07aSa/Kw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
References: <20241023090153.1395220-1-ryan_chen@aspeedtech.com>
 <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed: support for
 AST2700
Message-Id: <173047754439.1930424.6922132618537420144.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 16:12:24 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 23 Oct 2024 17:01:51 +0800, Ryan Chen wrote:
> Add reset, clk dt bindings headers, and update compatible
> support for AST2700 clk, silicon-id in yaml.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: aspeed: support for AST2700
      commit: 76c6217c31266e800b67a476bba59dfeb9858a90

--
Lee Jones [李琼斯]


