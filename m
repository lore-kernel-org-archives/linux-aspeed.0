Return-Path: <linux-aspeed+bounces-102-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9897D5D695
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 23:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xkz7Q2VXLz3brC;
	Fri,  8 Nov 2024 10:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731022770;
	cv=none; b=JDXch+CHdhPvn8l+QnAqcA0NDr19yO7YRGojfxJ0rc8BKJVfdopjUhBD3fv/SZeYi5+zqoXu9O+Ru8zDgwJ8f3W+TdE/xq/vghLoIDRjpm/vJMqBBms17NgqRiTv0U0WvnliMN97Wea1tdUVpMqmkgXXIyf5zlU78rwzE+2TiCUPpE7ED6VCMCiWb9dbNoMjHWGn3PhYfLAY/LQLmbGlsbMH5WY4P0FRaQ2R24/syZ7kHtOAjJHL3vvMCZeskjsT54jWJHRTffthrpdMTRTfjWOdj980zrAteAA1DniGixV2FCLLyRUII9x01EGF2tAwLmfzZ+FtbkScF6IBWyMAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731022770; c=relaxed/relaxed;
	bh=A5bjyyAWYr+VR/DxJGgp7mRweAiKTLFWuDoMtqHPdt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwLyBpK6HjNxb3YG1f8yI99ToFRnejnQDZA/LIngupmJqzfGVWQpCwtkTBIBYjKpX+GDbqf6qpqyijNXJCySNGHIH9KO6LPSVS6mLgFd+WsF4uOsP0YYJDZSCN/Hf0sn3h4mFuKHyIxkFMRbkA/mCeD53DErvzr4MvXEod8FjYilHCnE6NzWyKbY+z1LbbMupICLujKsUDVOQloNoCIjKesDZXqlzEwC13oJneM+cHDe/cmD8zVFPYKZ0yzBw0dTU5q/KVdt+q4ge6Q4mNDYATgaba+w5Ng82rMlzyStwKwwir+2DS/pcpYjOlW+xxGaZwrODLwpo48t1BVjMVryeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bqOTL1V0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bqOTL1V0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xkz7P4q7Zz3bn9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Nov 2024 10:39:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022768;
	bh=A5bjyyAWYr+VR/DxJGgp7mRweAiKTLFWuDoMtqHPdt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bqOTL1V0niQ4ld27SUYcHlDmAaoq5xSdE6TM4Cu7mkF2RsEJpecqiqyVPuUWIGNTQ
	 ICeHH8E6VMmRL/ULBPyjNck8NZar70M3f+zzThxoac1+zdqPdiiMrkzs4C7+bcp99z
	 axJyWMyc4x/hr9s/0Q0Aj5PMHlc/YeR54n+Bjj1Hgn59bxgRW2Siyhf44zq/Q4IDfq
	 C+qwyMxmczr1dL5D3Rq6H39SlHeiDYjRWeMIaTVN2F9ete38v8BRjqJLMcET5rIJqG
	 XogJixa7Ie4sXmj0XViwanp/VzRMD6l4uwBb2YTQRRKiKpnp1fhz/n49FnwzomV4UP
	 TvY7qz6AgVqIw==
Received: from [192.168.68.112] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AB35C6B922;
	Fri,  8 Nov 2024 07:39:27 +0800 (AWST)
Message-ID: <696cbaeefd0f731a1883771da3caa308ffcd03d5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] ARM: dts: aspeed: catalina: update pdb board
 cpld ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org, Potin Lai
 <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>
Date: Fri, 08 Nov 2024 10:09:27 +1030
In-Reply-To: <20241107-catalina-cpld-ioexp-update-v2-1-d7742eabc0e6@gmail.com>
References: 
	<20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
	 <20241107-catalina-cpld-ioexp-update-v2-1-d7742eabc0e6@gmail.com>
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
MIME-Version: 1.0

On Thu, 2024-11-07 at 20:39 +0800, Potin Lai wrote:
> Due to there are huge changes of PDB CPLD IOEXP pin definitions since
> DVT version,

If this is a different (revision of the) board, maybe it should have a
different dts file?

See the on-going conversation on v1.

Andrew

