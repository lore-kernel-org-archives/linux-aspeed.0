Return-Path: <linux-aspeed+bounces-4514-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D13C44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 05:42:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4jnN1vpzz2xpn;
	Wed, 22 Jul 2026 15:42:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784698936;
	cv=none; b=cmKl4IZxGWX6b2jDJYbXIA4o+u/VQEdwa9H6HqXxh63VlPuUB4omP5rsZrcH6saE7GUMWJGgczEVLQRG6iXP4gEFd4maKN+0Z16vmetRM2/yuUlvBrTXm/CZCjHIILzOsbLqBj2yXnGE8jooplUt0WHbysUsUj9oAn4oyyrzr6kDxskYMpgjpjQPQHHtCdCNBxs1WBXzkfiqBgtaomBOyP9JHpqb3MghlSb7mX1O48Cm0Gn2xIe3fpfD6HOUFeIdUcY1SDVe2/dFooLnD4Xgt2rrvqp0dIr11ERJTR1NjFA52s97nYs4HLURAc1UfTPSl17yjD/Hx/7db1JI2zs5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784698936; c=relaxed/relaxed;
	bh=hbQw3W0t7DCWGLYQc20VbVCF0idVw+jcX4clr+Pc7k0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HlNowpBnExgpNc0kDAjtAFzV7xY1eP//g8m+iiUWMfOhxxFSllwODuJr7M2Vo9Dfc/tD1rnZzWY6nm4AMlD6NxoxEJlPkdE3aQdme/Ds0bzqk70OljPr70O7Rj6oSUx+sq+OxpBwsz/k0VRGMRzJ3TtHjPU7m/ViJwpLB1xMZ3c2l5q7zxORHZ/KQX/wH5slYb/9ttUV9qyDBVMMgj81M80PDYgfSCbFnQwHfvU86VcVW6GteoTj7VnHiEVwmOKB3OOgPSG89wtAV6y7gpNkXQ87OtC5Q3k/bdOM9zULIXno1xP8FNd0fpi6+svZqIipSntOxxnILfZgSoGYfuk+GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nIScDihU; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nIScDihU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4jnM3gY4z2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 15:42:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784698933;
	bh=hbQw3W0t7DCWGLYQc20VbVCF0idVw+jcX4clr+Pc7k0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nIScDihU9wxPUYN9bA4sZT6/4MEoB7cAybII5TNLOm4Fc+o9ccci2sNpQA/ji50gV
	 l1VNEZYBy49MJezDHQfIa1rK1xfa3xvV9kF6R67D6S4DDf/voA6PAGQbd6NKwUsURh
	 svx2rmKzC+XFEEdKvBq6Ai4w2VQMqWgS/FVoOakbuwPKk13BDlhSSJ2smYwj1LFYmY
	 X/q0ql7zj1XQbWs3vcE8rpJjCUbvT5AucOdDFHJ+G1StTzw24/hJHcldOq2bYjhksn
	 6VUbDvT2VR6mM870VlKSujo/6W3DZtuX9BwcrmqjTEvqF7BgR+sLcZRR83ByjtoBO0
	 sll7oWMTbxjWQ==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2EE1165B37;
	Wed, 22 Jul 2026 13:42:11 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20260721-upstream-sanmiguel-fix-fio-ioexp-intr-v1-1-8245ae0ca590@gmail.com>
References: <20260721-upstream-sanmiguel-fix-fio-ioexp-intr-v1-1-8245ae0ca590@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: sanmiguel: Fix FIO IOEXP interrupt
 pin
Message-Id: <178469893176.629993.5702015627237024967.b4-ty@b4>
Date: Wed, 22 Jul 2026 15:12:11 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 19:01:59 +0800, Potin Lai wrote:
> The interrupt properties for fio_ioexp (pca9555 on i2c14) were incorrectly
> configured to gpio1 with ASPEED_GPIO(B, 6).
> 
> Update the interrupt-parent to gpio0 and the interrupt pin to
> ASPEED_GPIO(C, 6) according to the hardware specification.
> 
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


