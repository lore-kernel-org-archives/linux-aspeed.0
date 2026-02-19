Return-Path: <linux-aspeed+bounces-3525-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F273EE9A04C
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Feb 2026 04:35:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGgXr3v17z2xlj;
	Thu, 19 Feb 2026 15:35:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771475724;
	cv=none; b=A7A2Wzj4OJvs58RPJulk48rpfj2RHA3is2zG0kjwItMNJQNImE0t9OfhIYhQl/QhoyEEHngKi/u33njoHNssah4meaLgcaYTHDkWQG9bWGzj7uK8kwzdIrMIIG8LmKdbIcxnk8Nuy1bf6n99aDjvZhwhA6u56SW4RjUa/9pHhzQzhlNNZr5O4rW7W7HtJaWLwNvkRliZlzckGNPzAQWhRP3FlVDCW1NGR27iYc3yiah16eaCY4io3pklK0KSOv53cpjnxTMqfbpfZiNjauA3MPN8nRDO+T8qOgC1DXJlyZIyxLtOOimzOF9cWEsBNLlYT9iYGXQiO+hRAMlfJ3Ai/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771475724; c=relaxed/relaxed;
	bh=dbQGCcXacygdL0pttgXnvjZ05dWekjLf5mE44UOfY4I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PFe+mmxqBOBVM4t8d36knsVkKMtKqd7kH9GF3+wLr4ObC+aS9F2pj7SNe36ByqXdL4W1PWO0y5uRaWkJYHAGhhoDReTegIgls0DVl1Sw/hHTqD5qjO0tHRNdnTPCvTdqOl4aKKBs1t9ktK5bczhdqDXDmIT1P8Ixisk0SOt0ayOfGFVahSfzg5ATascx4d+C5rX2ZHut76T0V4uyTJWKNO4qcwYZbZ6bzxnGmsxBps5ONTpEiFSchz1FDSB/b32ahtoPzqcmsoiIQQHHNDHoStSjSFglz0q9ORCpdHDAhSQTWJmGsdq/sn/YEBa8PR4inNuSeBTHfm160nAUZLPmIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=F9yTs8dm; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=F9yTs8dm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGgXr07vfz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Feb 2026 15:35:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771475723;
	bh=dbQGCcXacygdL0pttgXnvjZ05dWekjLf5mE44UOfY4I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=F9yTs8dmkr63M3IBkhGpgOB0FzU3XHFQDGa2PkvS9vvSCL05b3ywnu7EIT8zJYWQ4
	 nHKDCoL0uOVUMJKR5G7fwOJUVQArkS60TDvPRMgb0e2CaaScLe2pOfjDcXlNOuf+4C
	 OyntBq1bjEgs7fj2tOiJJahZ5T/e1xj7Hs1KkavNMJi/DY7VlwtyuF9s2p6Yn6QbCx
	 RLVRAlKyiOnyqOyz3o26eUL5MPviPYgbC2Z9R1owURtXww4ZUldV0xkqRIraPMi6ZW
	 qii2gNIdyrrfbWR6jnkIjX+cFy8Nh4aAXbTqmL5MYuZnUXPcDQmNPjCw2DAePOqkwP
	 af+458OiU7D9Q==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E1CF160033;
	Thu, 19 Feb 2026 12:35:22 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Carl Lee <carl.lee@amd.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 peter.shen@amd.com, colin.huang2@amd.com
In-Reply-To: <20260209-add-nfc-device-v1-1-748d1a98b2b5@amd.com>
References: <20260209-add-nfc-device-v1-1-748d1a98b2b5@amd.com>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: add NFC device
Message-Id: <177147572280.1160818.12060888145911808065.b4-ty@codeconstruct.com.au>
Date: Thu, 19 Feb 2026 15:05:22 +1030
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

On Mon, 09 Feb 2026 10:25:59 +0800, Carl Lee wrote:
> add NFC NXP NCI device support to NFC tag reading
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


