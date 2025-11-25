Return-Path: <linux-aspeed+bounces-2993-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D3FD0E6C4
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 11:20:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dG0cP6l74z2xP9;
	Tue, 25 Nov 2025 22:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764069653;
	cv=none; b=i6pEe85coGNdb7DhKfNqyodBseYJau2cQ7md4pIsnfZF0JXdJbe/sr5L9DcP20rZ1IgbOT2hoQWFdsSwArkpkZMKSp6flyJ+2ldpLNlH/EGbMBNyHfdq4B14x5wpw6MKEkGCV47D2GYOpx45ChjGR8zw+okBFbLEI8s4teSS45ANd3onnomL091KSIHCEXmOAB4cchZDb8Nqrda4udPAfZMEHU+TmH0s4eW2aUuD57FJLLHUgI3jUQxQ5VSbBa608gby9EG5gx5uPd4UMB2EOUZjNaSM1p7Dka3+nznoT+/gyn8ZKOu4Y2XZW6X7BC0bnl9Fd36M2n4RqINk8DN5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764069653; c=relaxed/relaxed;
	bh=3q4QAXxw5qYmSm3JOhxGmlmUFZPBVIaZaJkp8SpF5fM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hageOTOwT+Iww6A1dZIqZ7s9JjnmeH8WDnzU9Fu78uAax6oFOMX3Uk3kvspiyxydUS+DapmcQNCQ9RoXQE/8Io7ULJ54eLp6sU1Sm3d7K8BgzQEetCn1TLK3qfmD60HuB/OQwRPEb+i/1qAEkrz1eKkMebScVJvEPyadH+FvCVrOudbEQpKJeXYJp/AbFUoLVJTiun/iihtEZuTXLOuW3ou4xrtRwskT3ZSVx+XlLJQ4iz2eY8+mOu3L9KPV+ePlA26Q7cgOY6MqJ7lctmYI8KpK7x5UrJiElYmljExwdXXxtgqicfHuXA1aRcIYnOTt0YoJgnGnyKig77EYKpx6Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oaPS1q62; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oaPS1q62;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dG0cP0mcJz2xNj
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 22:20:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C0F3601A4;
	Tue, 25 Nov 2025 11:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE6AC4CEF1;
	Tue, 25 Nov 2025 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069650;
	bh=XYrx8RmeHb7aOA0CRDqH8AU6e14CroGHa3JB6p/8Hwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oaPS1q62knOE86v73tj8F0OwlgiXC8DDnxnXWuNNzxJtIfVDndEWU/Jgc2boBDHp0
	 apzOhF0F+qhrSLQDUdm+bd3rsX/F7jW42rnqF23lz6pC9y3pDoMmHWw2ig4JJOscqM
	 ijQKpXH8HCa7VRENGJpMkSCulaWc7lQS21dbllP3L63hl9bLBNkh20h0+JwSRgxQHw
	 e0jEjaAVyRPlNyHC8t2UsHZuw6QEM4ID2Icky2NBPwqs/SI6DU5RaJ+SumF/2vGlyQ
	 LEzOAeij94Uk3Dx1LLLtRPMdeiQ2/STxu5IvTp5YPI3VId+UP6u/JfXrnOyK7JkQFy
	 JbI8tJKJ8ByJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4C33A8D14D;
	Tue, 25 Nov 2025 11:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176406961249.690498.6624376735038476395.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:20:12 +0000
References: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
In-Reply-To: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 andrew@aj.id.au, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 11:52:03 +0800 you wrote:
> Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
> to "aspeed,ast2600-mdio".
> 
> Although the MDIO controller on AST2700 is functionally the same as the
> one on AST2600, it's good practice to add a SoC-specific compatible for
> new silicon. This allows future driver updates to handle any 2700-specific
> integration issues without requiring devicetree changes or complex
> runtime detection logic.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: aspeed: add AST2700 MDIO compatible
    https://git.kernel.org/netdev/net-next/c/e3daf0e7fe97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



