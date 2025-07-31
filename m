Return-Path: <linux-aspeed+bounces-1866-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB39C87FCA
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 03:32:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvlX2gmGz2yLB;
	Thu, 31 Jul 2025 13:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753932728;
	cv=none; b=cjqczd5EJKcPEwuQX4r3nPfbU/8Pnidun4luyfSHbCp+aBkZkFwZPmOJStHs0ldHbp2k3gPFBRImzIsBii0mNeDr226dms8vxlo8zwrH6+2uFdL42PparNcRNv1jJ5wrWmfzIypKRNP8KJEV75Nre+U0QdO0L/rRjyETHaeajPronCu9siNroJax8HHu+MOCZJLcxZM3Jm50TzDE1AuGyLW/TJH+gIh481EfwZj7wRX2AUR209lG7k0Xrosc1JlZYsi1rl5kTp+y7xsbWFBskA7rSWz6j+zxKWyQkvFEHHx7vYgH3kEgg6DvsLwkIaQm9C4UX05iKJAW0q3FRy0MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753932728; c=relaxed/relaxed;
	bh=quiVJQfgnApnKSx34eCN3/yRSyocJqA7hv+N5gRbILQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P2yE4DQslWXaDDfTaDsmrNNabqM0p3MMk6NVio7jU6/o5QCwvTQJbxXBOSlKOlc5a+nBLc5SuEUKpln5Qv1NKXTwDj6yMBMikMihZUpwSsfGvjGxb1OkG49yQ9HcLlZ230ewFMay/L07wtlqNJFQIrNxWzpemhQKD/DQNnqx7y4I8Lh35qqpg9hX4DO+TeLp1qxG3YsqW8tB7wYXePnRMU1xbUOf8bf/N7yCAR5ZuuOMFOD+uV5jZF+3nwF5a0L0Cn5iqx+I7ga/DRspVwfFUi6ffOSeO9lhb8JHVpCsy5PDEZJrbreNPQm5XBEZn9Wd+MyrujwgMRlm7jSUW276Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HED3WeGH; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HED3WeGH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvlW5c3bz2yKw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Jul 2025 13:32:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753932726;
	bh=quiVJQfgnApnKSx34eCN3/yRSyocJqA7hv+N5gRbILQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=HED3WeGHV0Udep18IegiMfm6WyZlqxMnpgN54EKUnt8wMgVd8M0P+zL0YU6xOr1lO
	 QmRpXuJL5BNJ4pgcIoRvFv5u6B6FR8zIjKg7jFqkngbo77xRRVHegq8daiCUNuT9pb
	 3zA/k9KJVq6oeEgE55h+3wpLuwI6MyzLNKmPLhQX/eGppaQ9LSX1rFv5R/EFj+NP2e
	 VWy7+O6U/GcDfhS8/E46pba3iH2HuLmRAFoQcAA2Ztn3cazv800rajqNjABIh/dgOL
	 F/sL5gT+Db9YVVfXP1nkufrPIdBh5i6IKvji58x2S+X456962TN3pQaLf5bcuSwof6
	 b1a3QTn9Ct97w==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0D10F69374;
	Thu, 31 Jul 2025 11:32:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>, 
 rentao.bupt@gmail.com
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Message-Id: <175393272444.1011263.10036967590309258484.b4-ty@codeconstruct.com.au>
Date: Thu, 31 Jul 2025 13:02:04 +0930
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
X-Mailer: b4 0.14.2

On Sun, 27 Jul 2025 22:56:02 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


