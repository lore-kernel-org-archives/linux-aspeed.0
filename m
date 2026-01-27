Return-Path: <linux-aspeed+bounces-3433-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565E3D2FEDC
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Jan 2026 20:06:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0xHZ3LNlz309N;
	Wed, 28 Jan 2026 07:06:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769509128;
	cv=none; b=ZFqr6XtFkI8zqJ5bjY+07OprF9u7WlU3KjL3xZpcIw0WADN3Ij0SiKF4Rwqsm6CVMyT/LfnYo1KRXv36xZYBpiq8N+DZRdqrAN4u5mi+rMNelIQeCSEmryJ5Dcezx94X701XmtElanBKfZYR6UGP8j6TblWafZB08YQw/KqayV2hU2W9WB3+1/haASi7nu6r5XnPdmUfRh/GFGsIaXfeVeymUZooDghzul7Ydtzwqh3XZRj65WXPMqHOmpCwFzTjauH0N49kk+YXi2zDVfYob3mEn/n+JOrj+1hut65at/AZ0ks/R/ahMFq5pSIYFp1+4LrSImBhXRNSTwig/VgnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769509128; c=relaxed/relaxed;
	bh=5eLg8lvRXM1ve1El07YMeIhnVb/G8HJbWmSDSOLjgNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBB25Gu0/MS3LfDOCowQAaxp+E8alXDGVc9+7ZYJJYhH+UHDRiq7l2aD74M7WRwyjRmgXYdonG4tXm6VFP/7+YZgFuHQwbcDFUELVMejSjCnVxjxSWK+YzeFVLv++lbKBbpKSdixWTdHKCUIod3HElqsH98gnvhplVM+NYpNc1URQg7EbWthSXVtj3Ni3ECIlNY0TK3GOXlU1R9QIW64zaU30FLSrDKdpYgFCS2nQ4pmx/ZspqQWR+BE83QnbobxGQyHC/EeE213ohcvHI8mtiAxlB1LoaR1nUN6/G4C9lPkoqoqq7c1rm++ukxfEoku9/O8Vpd+f9cBsSqEZiGCpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EhCfTHkS; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AX7Du3Iz; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EhCfTHkS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AX7Du3Iz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0hFf1qslz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Jan 2026 21:18:44 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAHwZH786852
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Jan 2026 10:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5eLg8lvRXM1ve1El07YMeIhnVb/G8HJbWmSDSOLjgNQ=; b=EhCfTHkSCCqEqT8v
	sxtTfUo+UdFqN/R/lNeTo8eqz2G38XLCerWbKQ7ON7NIdO5Cnwj8aAXD07eUQPGG
	veO8iSgaJnEjkBro1hmTg7akNiFXYaQvy1hqsFgCa8Am+tETWL7SuDqwSena/8c4
	JaiMiMs95qSO2RJstGb5r5tgwfLerdR+iRE0bR/cYzB5yoSfKQ+8W8R/WnIHfqNe
	T1+Wvj9oqNZMdiKLX8fPCjk8zcMAZBBmdUqD/g9UbzIUpu+4KmPgfIY/FhQ8p4aZ
	BRW0QJRCyQOga9Y/tm6CjOv4IyAHfO9o373CAf4ATWc7kHtWVUCrgKk4mmHEzmpl
	klcG2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93j6mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Jan 2026 10:18:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c5e166fb75so1403212585a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Jan 2026 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769509121; x=1770113921; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eLg8lvRXM1ve1El07YMeIhnVb/G8HJbWmSDSOLjgNQ=;
        b=AX7Du3Iz7jNTeu7G4COqG8oBoC6AIch6fX2JcqwPuawNETr3sSa851L3mpsDS4cq00
         8iIYuwT8OYmk1pL8mXjJ62XlAgagW3rbjcqGzDk6afWYhc6KYZf88FroJxwld4jKQLUn
         nvNPs40qZgJnrWgNAsct/4zSBx0FWKQBCL4r8S111CPgAp6dVZ92n+Ey4n/1yYPQoSzr
         RftIxvEr3NJncjPLtW1JLSFr4/Z2iDt+wgm1eBUivz6SMItbsXWFgHBTgGKos0o6x9Pt
         SRRwXozl46KUFuWRCcE9roq87g2btHOkBY6uEGFR7miUCUJytnEhzTbNXBp42yWLgus5
         syuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509121; x=1770113921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5eLg8lvRXM1ve1El07YMeIhnVb/G8HJbWmSDSOLjgNQ=;
        b=DmToEa5rfRRJPefoqKuxOxAmlvMmtvEC/dXpZxbvadp2201x5eN9gIVHyMvTRuPKhJ
         8B/PN1JJIdc6GIV1kwnE/nyrFNqhqlHhWDJ8wEE9nLLDBBNWJxm/XuX41KMBaIjIk1B6
         kx8p9tKsJTj+Y/WuE247RRA60jldtKD3km6vgw3b++tGyZysxE44DCSzeV0FTqLpB1MB
         7BJdhIZavYSdtxUPWta6XLZDTg6/4qYHZo1uR/Lgn30Tdjl3/mushpPXBdX9Fy1YB6wl
         AcMp11LDiNNUQSueT6XF76Sn/9GIoIvb1XqmbXIRVi2AOFJkaYLAXVG1uM1bTImwvvp9
         KJlA==
X-Forwarded-Encrypted: i=1; AJvYcCUfWzJNpmHpH5MZYuebcp5U840ZihTDBhGEU8K6eoHtKyx6/YJmZKqqxSXD+b2wqPuJbxemTcXcgMcL9g8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0OlGTZmJrsPsp9ehXb+VoCVbcUa/Z4bMhPGzfpDLayCQMGTvD
	BQpLiVxPO7dk8duLTMnLhGxRfe+45XjI1jgSmIk1GVL9M9c3c4UeUvOFTd7GSgyytwHnR7IvlwD
	FBZ/gnRUR8Ysh8IvWSajZeQ2ZizXEiF4GXNrH1/VDW5Vx8JCNWehXH/An3cL+uBlczewb
X-Gm-Gg: AZuq6aLeR7Gz3PuO8lM54uVg89zuoJIyspW5Ng8FdkPz4byhBWzAMP16MPxLqYMDWPd
	LKlXki/Pv0tidasG07H4/5Vh55ALrDY4WrvRHSnmEtIjgVHi61KM/AYZGB/DeRh3APf1IsDWnCj
	5fpZpfdfhgS1eZYMdZIlicqq1REpW0KDqo+vD0WRU70YBg4joR6B0orsl8daHs7vgEip/EGQG/E
	nUlhxIc/V91WysGJIuKnvZiSotXVSafkMSEDF1iygSLpRcAyXObFNTQiFYkETp+0l0VREH3oYtW
	ib3L31UENggdpA370VFYRob/1oexjsFDxVv4yYtoS01bNWcZpPqEOIyKLG+v5jlpzSfAKxJQkLS
	+aT57O6WrM8/tNsgTL5bJV122/FE7EaaFI03ZEA==
X-Received: by 2002:a05:620a:4046:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8c70b8cfd23mr138532885a.50.1769509121414;
        Tue, 27 Jan 2026 02:18:41 -0800 (PST)
X-Received: by 2002:a05:620a:4046:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8c70b8cfd23mr138530785a.50.1769509120943;
        Tue, 27 Jan 2026 02:18:40 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:262e:d32a:e347:8b74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db7b434sm129589805e9.4.2026.01.27.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:18:39 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        bmc-sw@aspeedtech.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add Aspeed G7 sgpio support
Date: Tue, 27 Jan 2026 11:18:37 +0100
Message-ID: <176950911309.20207.17767153546829205311.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
References: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4NCBTYWx0ZWRfXxuxQUPkVypsu
 2P9ZqSbF36UVvpHbWoKi7+V29sG/+FceOieuzYMFkEm2dRFc1OW1ITO59UFszOIrgjouziwcYIs
 YXqMhypSu65trpvBxeRUw8eofUonJJpMKNtGsIZwzAH4DjJGDgK0Iy8U3DKxPr3fkXztVP50xYt
 ozc+LiF5Kvu0WHcMhCMNA5iQJZbhN1QLn+GBevHXXmXJBg3r4x2xgrFFMVpUu8qbkijGJfhxPXe
 V1pHnCCgmnEIYWYTHOROGm/Jo4zerBKbl1gGsVlnSMvY9L0l7CkuZJWLieevs1kIVAHKNdIyozl
 yVmy6cl3q5iXe0qgNlcnoKIH07JjS1OGf/wqsLcrrbJLE933Th6Fc4WRrI0gx/yyJSPdL8vL6Ex
 86/Bt/+6SPI7hiCVcBIIj70hwusZYGAQp1byVCG5dz3gc92PLReSv6CpkoNk7pEAhUX2VHHASaJ
 Zk0A02/hGnyNhY3lE8g==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=69789102 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oD6QKIyjnqh-ffyw0PwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 1jQJMCgL_4loBA7F8mtQkSCjXXahOUxK
X-Proofpoint-GUID: 1jQJMCgL_4loBA7F8mtQkSCjXXahOUxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270084


On Fri, 23 Jan 2026 17:26:25 +0800, Billy Tsai wrote:
> The Aspeed 7th generation SoC features two SGPIO master controllers: both
> with 256 serial inputs and outputs. The main difference from the previous
> generation is that the control logic has been updated to support
> per-pin control, allowing each pin to have its own 32-bit register for
> configuring value, interrupt type, and more.
> This patch serial also add low-level operations (llops) to abstract the
> register access for SGPIO registers making it easier to extend the driver
> to support different hardware register layouts.
> 
> [...]

Applied, thanks!

[1/6] gpio: aspeed-sgpio: Change the macro to support deferred probe
      commit: e18533b023ec7a33488bcf33140ce69bbba2894f
[2/6] gpio: aspeed-sgpio: Remove unused bank name field
      commit: 5928e0d1f66112b49869c83ed8f1cc9db3df69e5
[3/6] gpio: aspeed-sgpio: Create llops to handle hardware access
      commit: a3d37e0cccf530a1bad377b3503d6af757f532c4
[4/6] gpio: aspeed-sgpio: Convert IRQ functions to use llops callbacks
      commit: 43090d6993341b977ca66f4c72e776e99f7ba996
[5/6] dt-bindings: gpio: aspeed,sgpio: Support ast2700
      commit: 149470018e678b8fd62225c01be67ce2f9b5b1f2
[6/6] gpio: aspeed-sgpio: Support G7 Aspeed sgpiom controller
      commit: 274ea0f1687a849ded4f92d10e4c0e77f37740c9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

