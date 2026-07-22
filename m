Return-Path: <linux-aspeed+bounces-4535-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5D6C44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:08:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4yLl6Bp5z2yVd;
	Thu, 23 Jul 2026 01:08:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784732911;
	cv=none; b=adeXjZYzSYhK+rBnUmcPtfNEyEKOqTehXL4N1tZS7oa/ZDQCw3vXDtmM9vQV17mknNoYQcuOikTJ6Qx+O27NZgN9ZBTNZhDJFOGkzu8ZYncxP2oBQtxbSxsBWG9332P7Bk/Fn5I6eEqxxu/I82A4fbjRKseQ6sJs7M4g/4jmNl68Gk7EcrxVSTuPNRHo7IA9ZjhdHpcR/3hADSLfVYMBVEbzZ5p12pj7PefWGphvHi5gFnlOphcQ7Yl95m9S7r8gj49BXCiZtF2Ypn7sG17r4Gcmm3lxKPbgyVQr2isXKmd53MxvTfyZLfgdsiuY68J2yYu6QSOqOZ7DkNh8pWgOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784732911; c=relaxed/relaxed;
	bh=9ViNF3ZI4IEPivZK4iQepPlauUrX461PctikME+T1V0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eOZMWli9K494ATx3Rh2a/cHqSUFaJHVsCRqNSjObNcbBWxKJAjWAU+ArvmjOA/rbSRnAMRHJGGEFvflq8u1MPu2bOKJXtADFPJOYnY6ukgzT/lUHIrCTSMTEIp3HIIuP2QBPbSzGDwJfOi07fL4dVm62iu6A1Yt6y7N7Q93UeEwLUoDrtrQEZj8ASFnwsHTrijOwO3we+kSEKG2ZQCmOD2p0QPYXE0Cz7vGyMAaJgbzifedSVuK6kY/vvnvlVqiuzvc3fQFQhugPKeCyPv9q69Rqzf1D+nfBp9gTsYIltT4TuzFcduE86h0B6wkUnf03aQ8K/Cm3929gPLCNO+T/uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Zj8k9ffq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Zj8k9ffq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4yLl0bxhz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:08:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784732908;
	bh=9ViNF3ZI4IEPivZK4iQepPlauUrX461PctikME+T1V0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Zj8k9ffqCugrCsViAKam4XcJyJfzIq74EQQtQaQTCHHc1OZGrWgBPqCTx3y3QW7ij
	 e78BTqGHnU59QRC1sS6MI7NK+yv696QwJvsy4YIx7YGBoX2SWoSG9iTs0G6BhY0TlE
	 xgFbEqoP0BiA97teg6QcdVB2u7Y/tAXGyqZCCVIYcdugHbiMYCNSUCMW6VTXvEy2pV
	 cuIvQ8HEfVPkdJfRmS94AuWOkIg13yTQ4LHQ1+u8uPXVZ42CKVPRxR3hFTO3WSFt/E
	 oC5dd0TyEIUOHNmEBhAGELAYImd0IYTxjfqKdCgsMupdHufWBAx/j3d3NeUUhd3cSB
	 2wCRiUAHdmzMw==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0799B65B37;
	Wed, 22 Jul 2026 23:08:25 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260704122442.85499-1-pengpeng@iscas.ac.cn>
References: <20260704122442.85499-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] soc: aspeed: add missing MODULE_DEVICE_TABLE()
Message-Id: <178473290536.1914149.8003428473620995771.b4-ty@b4>
Date: Thu, 23 Jul 2026 00:38:25 +0930
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

On Sat, 04 Jul 2026 20:24:42 +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


