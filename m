Return-Path: <linux-aspeed+bounces-132-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A0DD10F38
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 Nov 2024 00:12:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xs7P323Xfz2y8X;
	Mon, 18 Nov 2024 11:12:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731888759;
	cv=none; b=W6J2JRv2p7y064pTJw1ivSaB/Im9iSjIaYHliebBZjEUkdXuQ9XbF/zM7UV7iN5el+bUNe59anncB39YmjDwZB30qx3XihATqFsbfA4XdxTrq3SwLTbxMivQtCxq8Uj/9wPCyxKW3ZpK7HYs6wsyYbgMdMELtaRyNrH1oGfruyVN0lwUgcFoSTV/eXYhoziwRDPff/gUWSe2EGl46Rtxb3DsCOSEs7XovQAIn5wYt0oODOSaFpXKzQnJvkQwkDtdNixJeKkEb94FU7S30a2mZIxcbndTaPB88NkzDMcMFa7s7eVHbe9OJbaRPlJYym1qZI7dp3VYjdMBWwfj2xxzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731888759; c=relaxed/relaxed;
	bh=lB3rlRLKTOOVAVSWBuHAcyZgBv2WqxsLN/5q+wlDRHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VhOn+XjQQ3kY7aPrT+thevQEmZ+Gph9ZX1YXipatCoN6uyzV90I3OsLvDCqm+A5XDAwSV6gMkBMHY++bxalA9uUomuPdbLePiVwzVHlYZLhc6PR53BsItgMWAy7hxhWFTOxKTeAHjD1i/WIPCyBxUmYQzHoYTf8DURdimdE//NL4ZVRu0idOAGtlBDJAMdBPZytFIEBwB0z1zQ4sEDUblRZTNvLw6DKlVo4tBx6/SSGD3/cWx5scymlDrh8+UZkep1mmbfY6w3Phe7zf/bizxa+zCABlMongIXZjf2BT9N/wjxubZDyMaLk4REwomBN38od368WEnbjvxd3H3bVzMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D0YsSmzh; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D0YsSmzh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xs7P13Qwfz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 Nov 2024 11:12:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731888754;
	bh=lB3rlRLKTOOVAVSWBuHAcyZgBv2WqxsLN/5q+wlDRHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D0YsSmzhuneD2/YXxuFfsBSJGvvThF5tlHvNwSyuiTJhE/WL+D3jng9ibaYsMirtW
	 6f2jGSWeFg5Vr63flpDTVJ018C+EmQh5eFMCo7qVI3rZd07VZq4jY/7hO/2DhkTH1g
	 wLzm09ObOZ0GQwyK5BwEoQY7o7kZoXgNp6yLea2ZH5fgHlmra8lldBZ8BcZhisZ6sq
	 7qTROwhTZKO5ORygntXw+ed+npPNAvYVcryGfD5+EcYt60q+9ynBBQN/XzRSwKTs9t
	 ovQhWGgO+U3HtwFze0JrFuyH5RnCYiCt1l8Co0s8m1DgF6jooke3C9Keoxv0BnWqK+
	 IvCUL7Cm2nDqA==
Received: from [127.0.1.1] (58-7-148-107.dyn.iinet.net.au [58.7.148.107])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4CE276625E;
	Mon, 18 Nov 2024 08:12:33 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241115222721.1564735-1-eajames@linux.ibm.com>
References: <20241115222721.1564735-1-eajames@linux.ibm.com>
Subject: Re: [PATCH v2] arm: dts: aspeed: Blueridge and Rainer: Add VRM
 presence GPIOs
Message-Id: <173188875323.217268.13798052651518745663.b4-ty@codeconstruct.com.au>
Date: Mon, 18 Nov 2024 10:42:33 +1030
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 15 Nov 2024 16:27:21 -0600, Eddie James wrote:
> Add GPIO line names to the GPIO expander to describe DCM and
> VRM presence detection lines.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


