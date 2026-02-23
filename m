Return-Path: <linux-aspeed+bounces-3532-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBD1E7C6F6
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 01:39:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fK3RZ6HFWz30hq;
	Mon, 23 Feb 2026 12:39:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771810746;
	cv=none; b=oON1H5y1ETCAeS48zkRk2JykBoRbpNwdwkXpRztxfXE6YS5is130VrMGT2Foe1i/pjJFt0juCHSSKso2YHGilh9KIUbvMYTiU5w0c00Vv5BbKDhwHsFuY7PlnXCUMMx9imNKxHKI/8k/NEy2jEQY8kBgG2dnx9aW9M3aM37+89aJMgF4fvhDk/BA56Ql5HN2YjxJZ9qcARW9sjA+wt7EG496TXkKX7Lz+y3H0bTFbA+DngR0JMqrpXc7X+m0GvtZVlgaa+95MxECQ60EHqLNWfyWIOQVjeyGOW63qVNL28lKFypHgdwV7u+PMvCf9j5goBRTk4IkhXMvK7z45qDayw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771810746; c=relaxed/relaxed;
	bh=MIR4lVMnkdb804M5R0VdfzVoSc5X3oa8pX/88m18+4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YVSUgGZ7hyCZtn8PesWJm33Wx2yjVkrhyTAmD2fcQWOxOx4EN7vp3BT2RYKTB9xEBhRRWXCwy42J7SOaUACqWFCFNVsaduGnFkPUgFsD1Dfq+/P17nSHElIL+TBPw2v4rn+9MjWrd8qUq87OtF0Q0RoFTVQAYEvxTtcP8rKGxdXoI3RwqGmRyCMb8NM0MGPaF684GOLrq+1ikWM+Gr7EFlMxF5E4psy1E+cDte+dXiPW3xQpjfgVZ8zTMi1l6wl95jL6IXjTjEItGR/JDQwSxRbLon8OYtHnELpUZ2BFNLxD9fds+UtDaLi7+s1FkxTWwQXfmMPnLSl9sd99xNnU1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Y6EXrtL1; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Y6EXrtL1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fK3RY54m4z2xSG
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 12:39:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771810744;
	bh=MIR4lVMnkdb804M5R0VdfzVoSc5X3oa8pX/88m18+4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Y6EXrtL1+IpDBKjQ+CE4IfTVsQtB4H+67UIbgSuuUBAw/68tx9orgqZhqB0my/a2e
	 DcfYfLefmXr/bwwiAnrpkKeEjF8vwqRW8pjxh906dww/IGvC7hTxGaMyqfSYy6TqQH
	 +/gGcNSOJpZngELx/1DV3zHiXzV+ftpQFDjjzCWoQ5GyHO8oeP5U6/L3Xmgl+pBs1B
	 NvPSZDM683jbwEBUqsiJOWJBqaM2uo+UGA3UFXk1F2H3ktnHOtuRQ/1eA44KReyEo7
	 lsGV2et7gbICX0wqS0Jq5Fo1dNVK3LnfRb2Mi/HPdrojDzDPxaZQBEiTHpmCNafSqT
	 6tGr3RRVwS7Tw==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C9C45600E1;
	Mon, 23 Feb 2026 09:39:01 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Dirk Chen <dirkchen@amd.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260219-b4-anacapa-dts-fix-v3-1-4f70fd2d1070@amd.com>
References: <20260219-b4-anacapa-dts-fix-v3-1-4f70fd2d1070@amd.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
Message-Id: <177181074172.1150784.15634520346683503197.b4-ty@codeconstruct.com.au>
Date: Mon, 23 Feb 2026 12:09:01 +1030
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

On Thu, 19 Feb 2026 23:44:47 +0800, Dirk Chen wrote:
> The Anacapa board features Atmel 24C2048 EEPROMs on i2c0 and i2c1, which
> are used to store retimer configurations. Add the corresponding device
> tree nodes to support these components.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


