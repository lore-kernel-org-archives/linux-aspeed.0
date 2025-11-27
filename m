Return-Path: <linux-aspeed+bounces-3006-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1961FD1118D
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:26:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGy0X4Hc4z2yr4;
	Thu, 27 Nov 2025 11:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764203196;
	cv=none; b=J4NxZQzvDrugD3Qt0s6Wp20tm6isUl6fDq59OOf29DDlIZ9ihZ+ECmfef6AuDdki+LoGGPOcl4WM5SLWYkC97Nzljn4qXS3qTyFXzf/khm2lG/INGAJ1p1o3cvGTchZ5mhFYM7yZJ24WJW7XPFPEIBUJiKy8UMb1JxiQM7pmFCWrlz5Cvz9vlyBmXc8cd0xcRGxuxjfRQevLG2XcZRomnrFb6sSdEIG6FkhxXAJ9gVgbZz4YDfIQKGUrq/tmSPgA1cDGkXWN19XFXxrgvaJGjLxJjMKpX2I9Yx0g4gsluSqWPQmpzlPvQcJhgKFvI77e39KaPtujMZLokG4RrROUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764203196; c=relaxed/relaxed;
	bh=Hb37+eqY9LuToN0Iyo4OSvoNajzOsts2KWtu7XI2Rvw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mchCVlfXkOa1gzH0700paCK3B+JMJDhdHmFXrc4uL1OKH1LpGjdEAMWqDp6LjfnwjvEuGywcQ4TK8zKwIyfIZzVu8cW1cZ1Q571Am8US+ur5v/tVoJDg9Gv3cPQXs3iaKwm6svFHimuYNcp52hfMWUzCjNhxTgCkZffr+O7+2m1DMm7bLkQoh94A7g1aVse69twCLhDIg1VY0FoXtgyjlqSxfl2ZyNqx6ezHJivYx69MQNrCyhaKXLeOkUdouKbWffvlydDR411P6f062B7FNDCsidqmiwBgy6t9ssYzLJ3A8rzuP67GsauMCNMBsj3EPqMdYo0x/ou+Zv3iS+ypCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nO1lNCri; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nO1lNCri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGy0W6qxVz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764203195;
	bh=Hb37+eqY9LuToN0Iyo4OSvoNajzOsts2KWtu7XI2Rvw=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=nO1lNCriYhjd+Th5Ug/C9mLvQyC9pE9be4c8sZStk8tFw6J5AJ2nW8zAaZhYTp8EA
	 X4iaNX88B0ND7ko441HSsgvZlwY1kt9Kllqyy0a0UXV4/WzE3FliAT0lTKcIi3FXU8
	 sBbkJAldQFp5XkMQAuccsrp99ASrNFWMZq59J896AGQHIrY8d4fP0XviGOkZPAxLXB
	 eLnlM1q7kTk5q5LcktGXbTt4po7ygqR0bAgxULD4qEv7FbGy1IhNuZqgPy6+bQXvd7
	 PrSa5bO3Gcu3cc6gO5A9vtVPcG7mlDKbdk0qn9gsktdz4stm3SneunoNVYVHdOooug
	 AV+9dcU0djuNA==
Received: from [127.0.1.1] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D43646561D;
	Thu, 27 Nov 2025 08:26:34 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
References: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
Subject: Re: [PATCH v1 0/2] Revise Meta Santabarbara devicetree
Message-Id: <176420319478.134548.6539551998232385591.b4-ty@codeconstruct.com.au>
Date: Thu, 27 Nov 2025 10:56:34 +1030
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
X-Mailer: b4 0.14.3

On Tue, 25 Nov 2025 21:59:29 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> - Add IO expander node on the switch board
> - Add SGPIO line names to control ASIC module power
> - Add IPMB node for OCP debug card
> Fred Chen (2):
>   ARM: dts: aspeed: santabarbara: Add swb IO expander and gpio line
>     names
>   ARM: dts: aspeed: santabarbara: Enable ipmb device for OCP debug card
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


