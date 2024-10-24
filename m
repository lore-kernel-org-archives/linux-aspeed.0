Return-Path: <linux-aspeed+bounces-25-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B142ECE8E75
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 13:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ66f1Blsz2ysv;
	Fri, 25 Oct 2024 00:23:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729776186;
	cv=none; b=Ctu8EKmPULJkEbVFp4vcuuGH1Z4OM8X5Mj1xHFLtq7aK9Da1jYYtJ1O6TZXmuFT0fZF1P0DU7yZ4VnkQIZGOFPz7SL0y84T3YmBmWkS88VL65Vo44E/rU7+WMitoIfPRsh3OvIoLV53dtRPj02u0XDtpbVt1AEGUV0QNd029Y/HktKVgH1KVhs4eQB181p21HbRx696DnUU9oL0eBEJiUpMoB6oS+Eb2q1l/uL/dUHD9pZC1vomXWWLQwmTzLsFAgdgkUq2BmTQ7bjEigcgLJ3H50MQrk1wjVQoidCmRDUruZ9p9xw5Y/28ZhBdervYg2bTH1TbJz2VnfV93fTG8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729776186; c=relaxed/relaxed;
	bh=08lXJgKcAe8N3lleod88TNBbTcd1+2/PW8hqN4eL/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjsPl88s0cI0pedOzu3mwpE4HlOncIh/gLlWqr99vhOKcF10sZzbNUorD/sqCUtdOugS1n+Ooyat0nvHCBDnUVuPbfP/WGqY7cSC3P+aMlfHsdbXhS2xV5iMUijEYi+RqdoX9yj2DGsgUGkKm4DD0LpDXXquOdirEBEYJMlQva2o5E84Erq+IDx7l2oBxx26SSnsY5Wiiw/sz3VffYtT76ZYHY+Yxwugy0qA2wMqAkv/tnGwkVokvXFaO4bLPQi7mDOxdzfcocMRvxa9dRW8CP/uwaBCwhCoK76MMX6zzs/kM95AgiDztvgr0o3vJJvSjoujkk5S4J95GjudmWLsuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UE3qlqoc; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UE3qlqoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ66c6slWz2yj3;
	Fri, 25 Oct 2024 00:23:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 76001A45419;
	Thu, 24 Oct 2024 13:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B136AC4CEC7;
	Thu, 24 Oct 2024 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776180;
	bh=xYOd1PGCn+k3tNRpgbdP98I0aYi1W9inhgTkL3ocTDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE3qlqocUQQwG7+oevrCYRcqdU5t6igksP5NXhM/w/Avp9vTWc9do/b/XFIaLNfV5
	 nF5Mu09+yamxjgYhYGBEQmyp0jczN/DdGoDW33UtiPMUXVeEbuIhBF22CiQpgWVwV0
	 qUkHRqiDvnAE6+n+Gx1vJ81KFaa+9tUo6F6L3DmpRpnwHnc377u3qWPsgOaTM457VE
	 v9l5/b2mhN5jG+3lRx8YjH+eLwlL5IZ6wRAjXlWNtm0ptENvdOtcjvulFw+AvWDq6L
	 LQWX29+MFnAHc+tALWO1lyKg/mbG/pBQ6CBRa5K0LSHIpv+WZigHO6oDUKFVVqZmqs
	 gAPURf4qcQhJA==
Date: Thu, 24 Oct 2024 15:22:56 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Tommy Huang <tommy_huang@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	"brendanhiggins@google.com" <brendanhiggins@google.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, 
	"joel@jms.id.au" <joel@jms.id.au>, BMC-SW <BMC-SW@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] i2c: aspeed: Consider i2c reset for muti-master case
Message-ID: <c3ss6ralf4tpyknsda5p745a65xjprlzecdq3s4zy4dpckuxi4@izf7emrzykay>
References: <20241018034919.974025-1-tommy_huang@aspeedtech.com>
 <e06a0db538bf62d4aeb7352ecc81a3a679fb9eec.camel@codeconstruct.com.au>
 <TYZPR06MB6191EBA63B87FE5152AF029DE14C2@TYZPR06MB6191.apcprd06.prod.outlook.com>
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
In-Reply-To: <TYZPR06MB6191EBA63B87FE5152AF029DE14C2@TYZPR06MB6191.apcprd06.prod.outlook.com>

Hi Tommy,

On Tue, Oct 22, 2024 at 02:42:08AM +0000, Tommy Huang wrote:
> Hi Andrew,
> 
> 	Thanks for your comments.
> 	I want to fix the situation when our controller is set as target mode and reading / writing by other i2c host.
> 	However, this host is stopped by any other reason (DC on/off..etc).
> 	It will cause the controller is stuck in this situation.
> 	But I find it might not have clear hints to identify this situation is normal or abnormal.
> 	So, this patch should not be applied into mainstream.

Please, avoid top posting, I don't understand which part of the
original message you are trying to comment on.

Second thing, please, before sending a patch, always always
always make sure that checkpatch.pl reports '0' errors and '0'
warnings, except for few sporadic cases.

Andi

