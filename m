Return-Path: <linux-aspeed+bounces-531-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5CDC02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 15:16:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdSMy6HLqz2ykn;
	Thu, 23 Jan 2025 02:16:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737558990;
	cv=none; b=n4tvFNLU85xvWPkozKzc1fXJj8RB3ikRlfoaUR7hj09YYMCWDJnsmk/YvSZiUdBG83YPWygq1z9h8biMHxQlTjg/cuBoeZ2dMH7O23fZe4dsEvD3xiR6s9a26EEQbTAFjCciWis708MkEOppWHoH0MKOG8E1J2QN157f0OLN+8QBHPuT5R1GrwdMpj/dT42jUoPQaqaf50aqwdIg9II3FgOLPL1VatAU3Qc/jPrbYcC10UoVR8HpxTc0ccXPcq6M3Rn+QLy+hetKU/yDELWAFm1l9+1v5b0YRjve+Ujeh5Hhkv1UwYsjUsxsN7QPW2RkgfL7+fFLxTzxbfNX3hoJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737558990; c=relaxed/relaxed;
	bh=YBli4K5HL01rSUVG2c2FKHPJs1SD/csZLpUS+Sp36Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ByWdo3y07tbqoyDJZVnBBJx9nCbnuMgNSIGMWl/H/GETkghjq7J+mC7JWj4kThZm4d7ZweRThcz0PK5mKpWfwktNiVT3xisEvzZyowrzrOQCQENi0pRqnlcoPd/+NLbXG9QCqV6rG/1rA4hP1rxyGXBAkKvToHhczVX5PGlMIZdw2fIBTFqB4KcRzZoO2ujKqixngIxMmT03rwA50cNJA3Vrzh8tirWPBNRX0sAzB+exk96iW4YebMBIp9Dh5lIazsZsRmsHvhUmyyzd7/Vlc3v9stw2L+CTTbyCiWo1L2zmgV5tXPTRy00qVGf69OkLREtmyjSgwLLve718NjKsgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W46Uh5Vn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W46Uh5Vn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdSMy0QqZz2yjb
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 02:16:29 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDmAH1013754;
	Wed, 22 Jan 2025 15:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YBli4K
	5HL01rSUVG2c2FKHPJs1SD/csZLpUS+Sp36Jc=; b=W46Uh5VnPtIXKwZLCOnOG5
	EIFpF1W3yTkW/sQvMnH8cU/OM/b9ywHYAKULSFSA/iVg9RnPWJnQvkwf7isXOIYQ
	yFt3gO2GknpX8UXALvWf5aTIyG5/8zLEoQ5UyY210WtS8HH+NOvhk9HQfEi7lPzp
	nnSbUDjVNTbSvsxBZR9tTh/eb/codBeBGueV8VjECosVJzfhlDWkzt0Q8Xoi050K
	bJgRe157VOmBRyYOXMmYTH8FcM1hXxj+CwlZ7SHDvvwj2FgX/KlyFygmTBfVJJ0n
	1MReGkyAjxIGlLkcctqZz1zSpueVCXvt2/vCOSwKquACyWAm09sU04c9WZsdJg8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bgj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:16:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MF9CWB006263;
	Wed, 22 Jan 2025 15:16:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bghv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:16:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MBXwPD032290;
	Wed, 22 Jan 2025 15:16:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujrnbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:16:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MFG8Ys25952850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:16:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24AFE58059;
	Wed, 22 Jan 2025 15:16:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49BD358043;
	Wed, 22 Jan 2025 15:16:06 +0000 (GMT)
Received: from [9.67.103.45] (unknown [9.67.103.45])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 15:16:06 +0000 (GMT)
Message-ID: <3bad433e-dfa0-4d76-915c-e6a4ee85e435@linux.ibm.com>
Date: Wed, 22 Jan 2025 09:16:05 -0600
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linus.walleij@linaro.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-4-ninad@linux.ibm.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hEHfMaY5ETen2ABLSnxKhKFJs0sVZgRl
X-Proofpoint-ORIG-GUID: Pu3fmilgIe-kY4vHe5lYNY-b-lpQJSMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220111

Hello Rob, Conor, Krzysztof,


On 1/16/25 14:35, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---

Please let me know if you have further comments. If not, can you please 
send a ACK?

-- 
Thanks & Regards,
Ninad


