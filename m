Return-Path: <linux-aspeed+bounces-3306-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A6D29DF3
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 09:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dr3qb3Gmvz2xWP;
	Tue, 13 Jan 2026 20:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768288672;
	cv=none; b=FMcDvI52k8MxY8q3oInVyaL7aahJdrBkjyzQJujESyfAAtZV7aXxLy4LM4GnbEV+hgSALnCzs/N7nX0PjeP9645KdDFKScbktowVk09oSBDL0Wd4BLkWehkeUUaY/My8xbGtr9Tz1aGOHSCPoulVlU346NbgkcScFQxkb+/Jaz7evO8fpTwmAG4opiQL1jFT92bZbeTv36Lo7hyW7Ciq56PZL13zUtrK7JDNsUdnZP5fSlFYqUrwZInvvuj9ZE8GwPsrAEFciHJ3FKOCVY1w+s6QAnBB8m6AoYb0rnrwZ1hpwzSfjY9Adb2LjqQ8JBXG8l1XUJwORcA2IvLM637GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768288672; c=relaxed/relaxed;
	bh=ZhKGgRnlFyhrair0DoeC6I/JMQGFqnL+h2onNiR7DrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfJjrY/wkxOBKl3Ohbri4USpxYAAzgGvhzfc2P7ycPL8RmIt217WYWTjrgDG/XrytwFCB4ispi5zB6xHwJ354Gn5+Xb5enmLAyo2isw+GW0J3uJXAr2i0rMRcVAI2qv0fjI+vHdQnMBeqBS1+HOREhKmzkpQgI9xkeOrIPim45k+DZ4w3iB6O3YjWfBSxdK0vkNNSw/z6SNhZ5KlW2G0v2B/pWDL7bLHTYEAokjdnZmp2Es3WUg5NYatG4HWiRxI3dMT9IeG9it2FmhYyBiTRP86176Ax7JWSR3ANjvKaYpfxNSqsE7m1pPbTHLxGYwy3r0z6jNWXAOQuOtcy3c8Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fKaCEjOp; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EfazvZ+/; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fKaCEjOp;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EfazvZ+/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dr0vM3gG4z2xHP
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 18:17:50 +1100 (AEDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D5bA2t3637494
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 07:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhKGgRnlFyhrair0DoeC6I/JMQGFqnL+h2onNiR7DrA=; b=fKaCEjOpJByST27z
	Oyqqyg4yNL1d8V6I2OBpRG/bVFInlZgNgzLG2CXDPVOQX/yXThOiU5icgzO0AkIy
	4sYQ0BlnHw+mySInTkl57N3cuKGJSnW9EtoGxqKvRgocoJvBtvBok8152xmkujtn
	DGZuePbucI06XN8HVvjt1HzhqjWPcZd4ijnq0I3KEOUCQoz1c5UoQqPejL7i4Gbx
	cUa5fOdAgXdodOjSHHV2b8ld1DrLREwKDjvyx/xlfZuL3m5nbJUNnt+JrblulPC1
	MXCicf82r/Y299WtO73XE1nBdoUVdKdNbsXKGCjo/sH3JiskUuufxVG5oEcxO6JH
	+FQLTw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng2c09w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 07:17:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b9ff555d2dso2053436585a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768288667; x=1768893467; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhKGgRnlFyhrair0DoeC6I/JMQGFqnL+h2onNiR7DrA=;
        b=EfazvZ+/Wy9jOAoc5TTT916AOE30ToR08akpWSR9tmSVDB4WD0aQBFSMKTEtZon9cS
         uJNBWEj8x3FbHj32MMWMzNJhBpQyOxuT/RIqR0OORaB/B2LyLA7sINZKEBnoNoz5iEqe
         dpja7HMH2d/aGdQ0LGJwECU0+vMN57PR1Aj/WEU2YKFgLQfZrHYdtvC9uQceFYByRoB/
         LSXYpR932wje90qUJ9JpkYxxWnTk7igbnKXPtiS+9lNYy7MJNpp6cjbaH8kOo2gADEJr
         5vKSoKtUfCtBj+aYdWj8FYYAMc6W4o7ih+hO90E0fa0l/QqlTKpY3aABs+1jnCd+3eqF
         S0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768288667; x=1768893467;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhKGgRnlFyhrair0DoeC6I/JMQGFqnL+h2onNiR7DrA=;
        b=Vy6hIP251RtydnSNmrEXKITQjDvuhHKOYiJqu3MDjvnwWG9hg6MYJk0f+s3RtZ/sXG
         IAJroy6+uj+ECwYuqu6U0tmEmaiGZisg4xvzbJkjfhHWYAcRJ+gWu08xuHBECS5smdjc
         rAYm6UHt1GQUDLLGvLwJYHCv55oSwWtow+9gzlitHflJiQuvt85hF6IdUcIBEqz707Lz
         i+FOKq7hlA/oVoKOfI6oiQ0Rg7DVGoHaGLArIZ4Rssor/BAbfE7dpfCB7d01NcD/STp3
         RXJBYiOcCtRH0xfu7SPJmepw8c/he2H+ltOYrWIaHRqW+L1IVYHsa0B2pzAXHto+YI3P
         vuYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWScUafdS0akDy6ycHkANCrTxoY+G2Z94/mJcW5Dq4+fevLIuDejBCCqpR/K5SEC2QWoqrsfFeGQqhKcE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwULc1bR73U3Mm0P3JmDf31hEjNRSzvi7qR/7eI/hxo2A8zx2LT
	Hvd/BQQdwaMWqGDJfOL3CQO2609C7QnbvkcoVOpHT8ixDi/StQShvUuuQVgQBzHTxz50ZSgOBKw
	iNBR5A7R71jTrpndjOJT/lJbQc5yqZgpO7Yg+5Ynmg/iYhjDT7xqnLPm3RzRqqBC/rIlE
X-Gm-Gg: AY/fxX7phndbCFOkA6e2rvtXnk7f5QkEc83bWUySBDrSrymWojJv5UoaX/SjlNdx63B
	57GmIlgeY8rnyZ3SWA7mgt0/Kb62x5V7PA0V5uIKOC3KXZzuKjLRWVXi4DmJyetm7fpJfjfW4/5
	GnuqdAOhF1Uqc330qNUCwaq7dwymjE5T5pQDStt7KS0raoSYp1JW2UZB5r8m7BgDHqGWIywKNmg
	UV3ZrXMn4iANJGgfgkiDdNbQrh+5eLRBgjRzPwOKwvqXuXugGregxWcfdeSaT2oj5xxZjUqG9XH
	ErN8YHpi/gvydSlug+Jx+/Ru2sClBRzQGm9oga1Wk5Xz1z/qjyJMQER7+lbDFAyoeVy8HFLBxyQ
	+2xzKlqJKnthq/tF8Zs80dz6DYwYh6j6lruJAfg==
X-Received: by 2002:a05:620a:1726:b0:8b1:8858:6ead with SMTP id af79cd13be357-8c389368b3cmr2631978585a.11.1768288667206;
        Mon, 12 Jan 2026 23:17:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExgQtRozhsAH49RpGxq/iZyoiE1zmUOcY5DHMgmcJAweCKrw5cPJcS2egnmIv7HerF/kkXCQ==
X-Received: by 2002:a05:620a:1726:b0:8b1:8858:6ead with SMTP id af79cd13be357-8c389368b3cmr2631976885a.11.1768288666786;
        Mon, 12 Jan 2026 23:17:46 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm956560966b.31.2026.01.12.23.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:17:46 -0800 (PST)
Message-ID: <c391ded8-6569-48a2-9c49-6b68838f91b0@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 08:17:44 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1OSBTYWx0ZWRfX04DunA7UTDJi
 aLJgV8mDPM/4L+YfWvQM2llFJT3SikKXwRei3aRFosSqe2vgz6VRdeGrhl8jVTvWp+PjyJVBh2L
 GwhofikTMC2bf37HFW8kAjk64Ggq9yeheQFY1yegomtVy21cpNu8VjBHO+7SUrZRoTIy4DSx+uv
 ZZ6Q3EDKO65aVaU07RmTles4LayEojdNNWVoNL/bIN/ImIiz63XpTouvNhaGcgmUbnejafvIJqS
 DN+TYEyX+zX1tm2n+FE4bleeij/W9hrFLYsBWPkbtnFJD4fWRcPtYzmRZXCW6iTI2dsklOP5u4J
 yeROq4qeuq/aJyLEh0H7p0uvNFsEys7zr24DkYzChNA/+QYkkwaxOpW8vi3tGXmkq9roeWMBjqU
 A/vKWt/k4RgoHNZo27oiJYQNDPLSeVMPVUg99C2soFJ4KsMaEnxfR9g5IgTebwumI099GG1JGTm
 6EH5GmhcX19AuqU1dsQ==
X-Authority-Analysis: v=2.4 cv=C5TkCAP+ c=1 sm=1 tr=0 ts=6965f19c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=dExqUudI3SiL9kWB0b4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: P0YIas1yQoKsbE8NJIZ9yj7DlDAiobho
X-Proofpoint-ORIG-GUID: P0YIas1yQoKsbE8NJIZ9yj7DlDAiobho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130059

On 13/01/2026 03:57, Kyle Hsieh wrote:
> Summary:
> Add linux device tree entry related to Meta(Facebook) ventura2.
> specific devices connected to BMC(AST2600) SoC.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Where? How is this possible?

Best regards,
Krzysztof

